from django.shortcuts import render
from django import template
from django.http import HttpResponse 
import datetime
import MySQLdb as mdb
import hashlib

# Map HTML names to Database names
department = {'CSE' : 'Computer Science and Engineering',
			'META': 'Metallurgical Engineering',
			'ECE' : 'Electrical Engineering',
			'EEE' : 'Electronics Engineering'}

# Welcome page
def welcome(request):
	return render(request, "home.html")


# Student LogIn Page
def login(request):
	return render(request, "login.html")


# Warden LogIn Page
def warden_login(request):
	return render(request, "login_warden.html")


# Show Hostel Info
def show_hostel_info(request):
	return render(request, "hostel_info.html")


# Warden Home Page
def warden(request):
	# Check for warden here
	user_id = request.POST.get('user_id')
	password = request.POST.get('password')
	# SignIn as Warden
	request = signin(request, user_id)
	if(user_id and password):
		password = conv_to_sha(password)
		# Connect to DB and verify
		db = mdb.connect(user='root', db='hras_test',  passwd='password', host='localhost')
		cursor = db.cursor()
		sql_query = "SELECT COUNT(*) FROM hostel WHERE head_warden_email = " + "'" + user_id +"' AND head_warden_passwd = "
		sql_query += "'" + password + "';"
		cursor.execute(sql_query)
		count = [row[0] for row in cursor.fetchall()]

		# If Warden ID is verified, proceed to home page for warden
		if(len(count) == 1):
			sql_query = "SELECT name, head_warden FROM hostel WHERE head_warden_email = " + "'" + user_id + "';"
			cursor.execute(sql_query)
			alpha = [row for row in cursor.fetchall()]
			hostel_name, warden_name = alpha[0][0], alpha[0][1]
			message = "Welcome, " + warden_name
			context_dict = {
				'message': message,
				'name' : warden_name,
				'error' : True
			}
			return(render(request, "warden.html", context_dict))
	message = "Please enter correct details"
	context_dict = {
				'message': message,
				'error' : True
			}
	return(render(request, "login_warden.html", context_dict))


# Student Check Room Page
def verify_for_registration(request):
	# Verify student data here
	user_id = request.POST.get('user_id')
	password = request.POST.get('password')
	roll_no = request.POST.get('roll_no')
	dept = request.POST.get('dept')
	year = request.POST.get('year')
	# Check if username and id is valid
	# If valid, check in already registered ones
	# If already in table, display message 
	db = mdb.connect(user='root', db='hras_test',  passwd='password', host='localhost')
	cursor = db.cursor()
	if user_id and password and roll_no and dept and year:
		password = conv_to_sha(password)
		sql_query = "SELECT * FROM student_id WHERE email =" + " '" + user_id + " '"+ " AND passwd =" + " '"+ password + "' " + "AND roll_num = '" + roll_no + "';"
		cursor.execute(sql_query)
		names = [row[0] for row in cursor.fetchall()]
		items = len(names)
		# Verify if the ID belongs to a student registered in the institute database
		valid_id = (items == 1)
		
		sql_query = "SELECT name FROM student WHERE roll_num =" + " '" + roll_no + "' AND department = '" + department[dept] + "' AND year= '" + year + "';"
		cursor.execute(sql_query)
		names = [row[0] for row in cursor.fetchall()]
		items = len(names)
		# Verify if student has already registered in the HRAS
		valid_stud = (items == 0)
		
		sql_query = "SELECT hostel_name FROM resides_in WHERE department = " + " '" + department[dept] + "' AND year= '" + year + "';"
		cursor.execute(sql_query)
		h_names = [row[0] for row in cursor.fetchall()]
		valid_h_name = (len(h_names) > 0)
		message = "Please try to login again"
		
		if(not valid_id):
			message = "Not a valid email ID, please try again...."
		elif(not valid_stud):
			message = "Student already registered"
		elif(not valid_h_name):
			message = "Invalid information. Please try again"
		
		if(not h_names):
			h_names = ["Ramanujan"]
		context_dict = {'user_id' : user_id,
			'roll_no' : roll_no,
			'dept' : dept,
			'year' : int(year),
			'valid_id' : valid_id and valid_stud and valid_h_name,
			'message' : message,
			'h_name' : h_names[0],
			'show' : False
		}
		db.close()
		
		return render(request, "check_room.html", context_dict)
	else:
		message = "Please fill all fields of login form first"
		return render(request, "check_room.html", {'valid_id' : False, 'message': message, 'show' : False})


# Registration Page
def verify_for_room(request):
	# Verify ID data here
	user_id = request.POST.get('user_id')
	h_name = request.POST.get('h_name')
	roll_no = request.POST.get('roll_no')
	dept = request.POST.get('dept')
	year = request.POST.get('year')
	room_num = request.POST.get('room_num')
	if user_id and h_name and roll_no and dept and year and room_num:
		db = mdb.connect(user='root', db='hras_test',  passwd='password', host='localhost')
		cursor = db.cursor()

		# Check if room number is in range alloted by the administration
		sql_query = "SELECT range_start, range_end FROM resides_in WHERE hostel_name = " + "'" + h_name +" Hostel' " + "AND department = " +  "'" + department[dept] + "' " +"AND year = "+year +";"
		cursor.execute(sql_query)
		range_i = [row for row in cursor.fetchall()]
		
		min_room_num = int(range_i[0][0])
		max_room_num = int(range_i[0][1])

		sql_query = "SELECT number FROM room WHERE hostel_name = " + " '" + h_name +" Hostel'" + " GROUP BY number HAVING COUNT(roll_num) > 1 ;"
		cursor.execute(sql_query)
		db.close()
		full_rooms = [int(row[0]) for row in cursor.fetchall()]

		# If room already taken, display message
		if(int(room_num) in full_rooms):
			message = "The room number is already full, please choose a different one"
			context_dict = {'user_id' : user_id,
			'roll_no' : roll_no,
			'dept' : dept,
			'year' : year,
			'valid_id' : True,
			'message' : message,
			'h_name' : h_name,
			'show' : True
			}
			return render(request, "check_room.html", context_dict)
		# If room outside valid range
		elif(int(room_num) > max_room_num or int(room_num) < min_room_num):
			message = "The room number is outside the allowed range"
			context_dict = {'user_id' : user_id,
			'roll_no' : roll_no,
			'dept' : dept,
			'year' : year,
			'valid_id' : True,
			'message' : message,
			'h_name' : h_name,
			'show' : True
			}
			return render(request, "check_room.html", context_dict)
		message = "Please go to login"
		context_dict = {'user_id' : user_id,
			'roll_no' : roll_no,
			'dept' : dept,
			'year' : year,
			'valid_id' : True,
			'message' : message,
			'h_name' : h_name,
			'room_num' : room_num
		}
		return render(request, "register.html", context_dict)

	return(render(request, "home.html"))


# End Page
def complete_registration(request):
	roll_no = request.POST.get('roll_no')
	user_id = request.POST.get('user_id')
	name = request.POST.get('name')
	dept = request.POST.get('dept')
	course = request.POST.get('course')
	year = request.POST.get('year')
	gender = request.POST.get('gender')
	guardian_name = request.POST.get('g_name')
	local_guardian_name = request.POST.get('lg_name')
	
	contact_num = request.POST.get('contact_num')
	guardian_contact_num = request.POST.get('g_contact_num')
	local_guardian_contact_num = request.POST.get('lg_contact_num')
	contact_num = request.POST.get('contact_num')
	guardian_address = request.POST.get('g_add')
	local_guardian_address = request.POST.get('lg_add')

	h_name = request.POST.get('h_name')
	room_num = request.POST.get('room_num')
	prev_h_name = request.POST.get('prev_host')
	prev_room_num = request.POST.get('prev_host_room')

	receipt = request.POST.get('receipt')
	bank = request.POST.get('bank')

	guardian_info = guardian_name and local_guardian_name and guardian_contact_num and local_guardian_contact_num and guardian_address and local_guardian_address
	hostel_info = prev_h_name and prev_room_num
	# If all information has been provided
	if(guardian_info and hostel_info and contact_num and receipt and bank and gender):
		valid_names = True
		for name_i in [name, guardian_name, local_guardian_name]:
			valid_names = valid_names and valid_person_name(name_i)
		
		if(not valid_names):
			message = "Please enter valid names"
			context_dict = {'user_id' : user_id,
				'roll_no' : roll_no,
				'dept' : dept,
				'year' : year,
				'valid_id' : True,
				'message' : message,
				'h_name' : h_name,
				'room_num' : room_num
			}
			return render(request, "register.html", context_dict)
		# Insert values here
		db = mdb.connect(user='root', db='hras_test',  passwd='password', host='localhost')
		cursor = db.cursor()

		sql_query = "SELECT number FROM room WHERE hostel_name = " + " '" + h_name +" Hostel'" + " GROUP BY number HAVING COUNT(roll_num) > 1 ;"
		cursor.execute(sql_query)
		
		# If room has been filled, try again
		full_rooms = [int(row[0]) for row in cursor.fetchall()]
		if(int(room_num) in full_rooms):
			message = "The room number is already full, please choose a different one"
			context_dict = {'user_id' : user_id,
			'roll_no' : roll_no,
			'dept' : dept,
			'year' : year,
			'valid_id' : True,
			'message' : message,
			'h_name' : h_name,
			'show' : True
			}
			return render(request, "check_room.html", context_dict)
		
		# Generate query for student table
		sql_query = "INSERT INTO student VALUES(" +" '" + name + "', '" + roll_no + "', '" + user_id + "', '"
		sql_query += receipt + "', 'Y', '" + contact_num + "', '" + gender +  "', '" + department[dept] + "', '"
		sql_query += course + "', " + year + ",'" + prev_h_name + "', " + prev_room_num + ",'"
		sql_query += guardian_name + "', '" + guardian_contact_num + "', '" + guardian_address + "', '"
		sql_query += local_guardian_name + "', '" + local_guardian_contact_num + "', '" + local_guardian_address + "', '"
		sql_query += bank + "', '" + h_name + " Hostel');"
		
		cursor.execute(sql_query)
		
		# Generate query for room table
		sql_query = "INSERT INTO room VALUES(" + room_num + ", '" + roll_no + "', '" + h_name + " Hostel');"
		cursor.execute(sql_query)
		
		# Add to database and close
		db.commit()		
		db.close()
		return render(request, "end.html")
	return render(request, "register.html", {'message':'Please verify your credentials first'})


# All Info Page
def all_info(request):
	db = mdb.connect(user='root', db='hras_test',  passwd='password', host='localhost')
	cursor = db.cursor()
	h_name = "Ramanujan"
	sql_query = "SELECT number, roll_num FROM room WHERE hostel_name = " + " '" + h_name +" Hostel' ORDER BY number;"
	cursor.execute(sql_query)
	db.close()
	room_info = [[int(row[0]), row[1]] for row in cursor.fetchall()]
	context_dict = {
		'h_name' : h_name,
		'list_of_rooms' : room_info
	}
	return render(request, "all_info.html", context_dict)


# Student Info Page
def stud_info(request):
	if(request.session.get('warden')):
		roll_no = request.POST.get('roll_no')
		db = mdb.connect(user='root', db='hras_test',  passwd='password', host='localhost')
		cursor = db.cursor()
		sql_query = "SELECT * from student WHERE roll_num = " + "'" + roll_no +"';"
		print(sql_query)
		cursor.execute(sql_query)
		details = cursor.fetchall()
		ans = [detail for detail in details]
		print(ans)
		context_dict = {'answer' : ans}
		return render(request, "stud_info.html", context_dict)
	return HttpResponse("Invalid access")


# Sign In for Warden
def signin(request, uid):
    db = mdb.connect(user='root', db='hras_test',  passwd='password', host='localhost')
    cursor = db.cursor()
    cursor.execute('SELECT head_warden_email from hostel;')
    details = cursor.fetchall()
    uids = [emails[0] for emails in details]
    if uid in uids:
    	request.session['warden'] = uid
    	request.session.clear_expired()
    	request.session.set_expiry(600)
    return (request)


################# Helper Functions #######################

# Return true if person name is valid
def valid_person_name(name):
	for i in name:
		if(ord(i) >= 97 and ord(i) <= 122 or ord(i) >= 65 and ord(i) <= 90 or ord(i) == 32):
			continue
		else:
			return False
	return True


# Convert password string to SHA1
def conv_to_sha(password):
	return(hashlib.sha1(password).hexdigest())

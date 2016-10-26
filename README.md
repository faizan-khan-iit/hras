## The Project

Create an online web application for the purpose of efficient and effective **hostel room allotment in IIT (BHU)** for registered students.

--------

### Breakdown of the System:

1) **Log-In/Verification Section:** The first section of the Hostel Room Allotment system, which makes sure the system is accessed only by authorized users. Basically consists of a form with required fields including a user ID (the institute e-mail ID) and password. This is checked against the established institute database.

2) **Input Section:** Once the user has been authenticated, he is required to fill out various details through certain forms. The forms should cover the fields described under the _‘Requirements from the user (student) side’_ section given in the _requirements_. It is essential the information provided here is valid and consistent with the information provided in the institute. This information will be used to allot hostel rooms to the students and may not be changed in the future, barring exceptions.

3) **Processing Section:** Once the student has filled out all the required information and successfully submitted it, the room will be reserved for that particular student. The system should take care of this section and no user interaction should alter this phase in any way.

--------

### Project Details

The details of the project are as follows:

* __Django__ version: _1.8.13_
```
python -c "import django; print(django.get_version())"
```
* __MySQL-python__ version: _1.2.5_
    
* Steps to setup project:

```
For python 2.7 on Ubuntu 14.04

# Install/Upgrade pip
>>> sudo python -m pip install -U pip 

# Installing a Python Virtual Environment
>>> sudo pip install virtualenv 

# Create virtual Environment
>>> sudo virtualenv path_to_env/env_appname

# Run virtual Environment
>>> source path_to_env/env_appname/bin/activate

# Install Django
>>> pip install django==1.8.13

# Create project
>>> django-admin startproject hras
>>> python ./hras/manage.py migrate
>>> cd ./hras
>>> python manage.py runserver
# go to 127.0.0.1/8000 in browser to verify

For working with MySQL
>>> pip install MySQL-python

# if error in above command try below command before running again
>>> sudo apt-get install python-dev libmysqlclient-dev

# Open python and check everything works
>>> python
>>> import django
>>> import MySQLdb
```
* __MySQL Server__ version: *5.5.52-0ubuntu0.14.04.1 (Ubuntu)*

* Supported Browsers: tested on _Chrome_, _Firefox_, _Opera_

--------

### Start Project

1. Start Server Through python:
```
# In Project Directory
python ./manage.py runserver
```

2. Open Browser and navigate to `http://127.0.0.1:8000/home/`

3. Browse through the project!

--------

### Notes:

* Only wardens are allowed to view allotment information of all students
* Students may only fill the form once
* The rooms are alloted on the basis of submission time
* For more, see the _requirements_ file

--------

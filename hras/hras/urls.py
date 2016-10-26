"""hras URL Configuration

The `urlpatterns` list routes URLs to views. For more information please see:
    https://docs.djangoproject.com/en/1.8/topics/http/urls/
Examples:
Function views
    1. Add an import:  from my_app import views
    2. Add a URL to urlpatterns:  url(r'^$', views.home, name='home')
Class-based views
    1. Add an import:  from other_app.views import Home
    2. Add a URL to urlpatterns:  url(r'^$', Home.as_view(), name='home')
Including another URLconf
    1. Add a URL to urlpatterns:  url(r'^blog/', include('blog.urls'))
"""
from django.conf.urls import include, url
from django.contrib import admin
from webapp.views import *

urlpatterns = [
    url(r'^admin/', include(admin.site.urls)),
    url(r'^home/$', welcome),
    url(r'^login/$', login),
    url(r'^login_warden/$', warden_login),
    url(r'^warden/$', warden),
    url(r'^hostel_info/$', show_hostel_info),
    url(r'^register/$', verify_for_room),
    url(r'^check_room/$', verify_for_registration),
    url(r'^end/$', complete_registration),
    url(r'^all_info/$', all_info),
    url(r'^stud_info/$', stud_info),
]
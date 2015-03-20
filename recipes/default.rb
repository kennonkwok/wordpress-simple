#
# Cookbook Name:: wordpress-simple
# Recipe:: default
#
# Copyright (c) 2015 The Authors, All Rights Reserved.

include_recipe 'wordpress-simple::database'
include_recipe 'wordpress-simple::app'

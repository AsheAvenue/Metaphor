require "open-uri"

class Admin::AdminController < ApplicationController
  load_and_authorize_resource
  layout 'admin'
  before_filter :require_login
end

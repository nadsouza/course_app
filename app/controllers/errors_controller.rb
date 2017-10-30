class ErrorsController < ApplicationController
  def not_found
    render 'index', locals: {heading: '404', message: 'Can\'t seem to find the page, please contact an administrator if the error persists elsewhere.'}
  end

  def server_error
    render 'index', locals: {heading: '500', message: 'There seems to be an error... Internal Server Error, please contact an administrator if the error persists.'}
  end
end
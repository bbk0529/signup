class UserController < ApplicationController
  def index
    if session[:user_id]
      @email=User.find(session[:user_id]).email
    end
  end

  def new
  end

  def create
    require 'digest'
    @email=params['email']
    @password=params['password']
    encrypted_password = Digest::MD5.hexdigest(@password)
    
    User.create(
      email: @email,
      password: encrypted_password
      )
    
  end
  
  def login
  end
  
  def login_process
    require 'digest'
    # 0로그인으로 받아온 정보의 유저가 db에 있는지 확인.
    # 1만약 있다면 비밀번호가 맞는지 확인 
    # 2그것도 맞다면 로그인 시키기 
    
    if User.exists?(email: params[:email])
      user = User.find_by(email: params[:email])
      if user.password == Digest::MD5.hexdigest(params[:password])
          session[:user_id] = user.id
          p "로그인이 잘 되었습니다."
          redirect_to '/'
      end 
    end
  end
  
  
  
  
end

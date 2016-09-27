class UsersController < ApplicationController
  #before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :calculate_equal_parts, only: [:index]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  def new_entry
    @users = User.all
    contribution_hash = Hash.new
    if params[:Amar].present?
      contribution_hash[:amar] = params[:amar_contribution]
    end
    if params[:Akbar].present?
      contribution_hash[:akbar] = params[:akbar_contribution]
    end
    if params[:Anthony].present?
      contribution_hash[:anthony] = params[:anthony_contribution]
    end
    
    date_filled = params[:date].present? ? Date.strptime(params[:date], '%m/%d/%Y') : Date.strptime(Date.today.strftime('%m/%d/%Y'), '%m/%d/%Y')


    User.create(:event_date => Date.strptime(params[:date], '%m/%d/%Y'), :location => params[:location], :event_name => params[:event_name], :event_money_spent => contribution_hash)

    redirect_to users_path, :notice => 'New entry successfully created'
  end

  private
    #claculate share of each user
    def calculate_equal_parts
      @amar_total_spent = 0
      @akbar_total_spent = 0
      @anthony_total_spent = 0
      total_spent = 0
      total_equal_part = 0
      max_index = 2
      @settlement_array = []
      
      User.all.each do |user|
        @amar_total_spent = @amar_total_spent + user.event_money_spent["amar"].to_i
        @akbar_total_spent = @akbar_total_spent + user.event_money_spent["akbar"].to_i
        @anthony_total_spent = @anthony_total_spent + user.event_money_spent["anthony"].to_i
      end
      
      
      total_spent = @amar_total_spent + @akbar_total_spent + @anthony_total_spent

      total_equal_part = (total_spent/3)
      
      hash_for_money = { amar:  total_equal_part - @amar_total_spent, akbar: total_equal_part - @akbar_total_spent, anthony:  total_equal_part - @anthony_total_spent}
      arr = hash_for_money.sort_by { |k, v| -v }.reverse
      
      arr.each_with_index do |obj, index|
      if index == 2
        break
      end
      
      puts index
      
      temp = index + 1
      while temp <= max_index
        
        if arr[temp][1] > 0
          if obj[1].abs > arr[temp][1].abs
            @settlement_array.push("#{arr[index][0]} will give #{arr[temp][1]} to #{arr[temp][0]}")
            arr[index][1] =  arr[index][1] + arr[temp][1]
            arr[temp][1] = 0
          elsif obj[1].abs < arr[temp][1].abs
            @settlement_array.push("#{arr[index][0]} will give #{arr[index][1].abs} to #{arr[temp][0]}")
            arr[temp][1] = arr[temp][1] + arr[index][1]
            arr[index][1] = 0 
          elsif obj[1].abs == arr[temp][1].abs
            @settlement_array.push("#{arr[index][0]} will give #{arr[temp][1]} to #{arr[temp][0]}")
            arr[temp][1] = 0
            arr[index][1] = 0

          end
        end 
        temp = temp + 1
      end
    end
    end
end

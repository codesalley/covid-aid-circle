module ApplicationHelper
  def current_user
    user = User.find_by(id: session[:user_id])
    user
  end

  def format_time(time)
    res = time.strftime("%e %b %H %M:%P")
    res
  end

  def get_chat(title)
    to_arr = title.split(":")
    to_arr.shift
    to_arr
    res = if to_arr[0].to_i == current_user.id
        to_arr[1].to_i
      else
        to_arr[0].to_i
      end
  end
end

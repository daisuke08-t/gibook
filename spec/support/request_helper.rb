module RequestHelper

  def sign_in(user)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({user_id: user.id})
  end

  def sign_out(user)
    allow_any_instance_of(ActionDispatch::Request).to receive(:session).and_return({user_id: user.id}).delete
    @current_user = nil
  end


  
end
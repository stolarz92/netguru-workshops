class ReviewDecorator < Draper::Decorator
  delegate_all

  def author
    "#{user.firstname} #{user.lastname}"
  end

  # def formatted_created_at
  #   self.created_at.strftime("%d-%m-%y")
  # end

end

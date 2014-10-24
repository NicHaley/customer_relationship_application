class Contact   #Stores information for one contact
  attr_accessor :id, :first_name, :last_name, :email, :note

  def initialize (first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
end

#New contact info is set within CRA.rb


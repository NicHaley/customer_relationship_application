class CRM

  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Display all the contacts"
    puts "[5] Display an attribute"
    puts "[6] Exit"
    puts "Enter a number: "
  end

  def main_menu
    print_main_menu
    user_selected = gets.to_i
    call_option(user_selected)
  end

  def call_option(user_selected)
    add_new_contact if user_selected == 1
    modify_existing_contact if user_selected == 2
    # Finish off and do the rest for 3 through 6
    # To be clear, the methods add_new_contact and modify_existing_contact
    # haven't been defined yet
  end
end


  # def add_new_contact
  #   print "Enter First Name: "
  #   first_name = gets.chomp
  #   print "Enter Last Name: "
  #   last_name = gets.chomp
  #   print "Enter Email Address: "
  #   email = gets.chomp
  #   print "Enter a Note: "
  #   note = gets.chomp
  #   contact = Contact.new(first_name, last_name, email, note)
  # end

class Contact
  attr_accessor :first_name, :last_name, :email, :note

  def initialize (first_name, last_name, email, note)
    @first_name = first_name
    @last_name = last_name
    @email = email
    @note = note
  end
end

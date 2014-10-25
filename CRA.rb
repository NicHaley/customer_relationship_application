require_relative "./contact"
require_relative "./rolodex"

#Menu options: prints menu and gathers input
class CRM
  attr_reader :crm_name

  def initialize(crm_name)
    @crm_name = crm_name    #Needed to name this CRM (ie. for a company name)
    @rolodex = Rolodex.new
  end

  def print_main_menu
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Search by ID"
    puts "[5] Display all the contacts"
    puts "[6] Show attributes"
    puts "[7] Exit"
    puts "Enter a number: "
  end

  def main_menu
    puts "Welcome to #{@crm_name}!"
    while true  #make infinite loop that breaks if user selects exit
      print_main_menu
      user_selected = gets.chomp.to_i
      if user_selected == 7
        puts "Goodbye!"
        return
      end
      call_option(user_selected)
    end
  end

  def call_option(user_selected)
    add_new_contact if user_selected == 1
    modify_contact if user_selected == 2
    delete_contact if user_selected == 3
    display_a_contact if user_selected == 4
    display_contacts if user_selected == 5
    display_attributes if user_selected == 6
    exit if user_selected == 7
  end

  def add_new_contact
    print "Enter First Name: "
    first_name = gets.chomp
    print "Enter Last Name: "
    last_name = gets.chomp
    print "Enter Email Address: "
    email = gets.chomp
    print "Enter a Note: "
    note = gets.chomp

    contact = Contact.new(first_name, last_name, email, note)
    @rolodex.add_contact(contact)
  end

  def modify_contact
    id_input = display_a_contact
    puts "Please enter new information:"
    print "Enter First Name: "
      @rolodex.contacts[id_input].first_name = gets.chomp
    print "Enter Last Name: "
      @rolodex.contacts[id_input].last_name = gets.chomp
    print "Enter Email Address: "
      @rolodex.contacts[id_input].email = gets.chomp
    print "Enter a Note: "
     @rolodex.contacts[id_input].note = gets.chomp
  end

  def delete_contact
    id_input = display_a_contact
    puts "Are you sure you would like to delete this contact?"
    puts "[1] Yes"
    puts "[2] No"
    user_mod_select = gets.chomp.to_i
    if user_mod_select == 1
      puts "Contact deleted"
      @rolodex.contacts.delete_at(id_input)
    elsif user_mod_select == 2
      puts "Contact delete cancelled"
    end
  end

  def display_a_contact
    puts "How would you like to search?"
    puts "[1] By ID"
    puts "[2] By name"
    puts "[3] Cancel"
    user_select = gets.chomp.to_i

    if user_select == 1
      print "Please enter ID now: "
      id_input = gets.chomp.to_i
      spec_contact = @rolodex.contacts[id_input]
      puts "You have selected:"
      puts "#{spec_contact.first_name} #{spec_contact.last_name}"
      puts "Email: #{spec_contact.email}"
      puts "Notes: #{spec_contact.note}"
    elsif user_select == 2
      print "Please enter first name now: "
      name_input = gets.chomp.to_s.downcase
      name_search = @rolodex.contacts.downcase.include?(name_input)
      if name_search == true
        puts "Name search was true"
      else
        puts "Name search failed"
      end
    elsif user_select == 3
      puts "Returning to main menu"
      display_contacts
    end 
    id_input
  end

  def display_contacts
    @rolodex.contacts.each do |contact|
      puts "#{contact.first_name} #{contact.last_name}"
      puts "Email: #{contact.email}"
      puts "Notes: #{contact.note}"
      puts "Contact ID: #{contact.id}"
    end
  end

  def display_attributes
    puts "What would you like to display?"
    puts "[1] First name"
    puts "[2] Last name"
    puts "[3] Email"
    puts "[4] Notes"
    user_select = gets.chomp.to_i
    if user_select == 1
      puts "List of first names:"
      @rolodex.contacts.each do |contact|
        puts "#{contact.first_name}"
      end
    elsif user_select == 2
      puts "List of last names:"
      @rolodex.contacts.each do |contact|
        puts "#{contact.last_name}"
      end
    elsif user_select == 3
      puts "List of emails:"
      @rolodex.contacts.each do |contact|
        puts "#{contact.email}"
      end
    elsif user_select == 4
      puts "List of notes:"
      @rolodex.contacts.each do |contact|
        puts "#{contact.note}"
      end
    end
  end
end

crm = CRM.new("Bitmaker")
crm.main_menu


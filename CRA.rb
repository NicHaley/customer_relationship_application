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
    puts "- - - - - - - - - - - - - -"
    puts "          Main Menu \n\n"
    puts "[1] Add a new contact"
    puts "[2] Modify an existing contact"
    puts "[3] Delete a contact"
    puts "[4] Search a contact"
    puts "[5] Display all the contacts"
    puts "[6] Show attributes"
    puts "[7] Exit"
    print "Enter a number: "
  end

  def main_menu
    puts
    puts "    Welcome to #{@crm_name}!"
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
    search_contact if user_selected == 4
    display_contacts if user_selected == 5
    display_attributes if user_selected == 6
    exit if user_selected == 7
  end

  def contact_display(contact)
    puts "Name: #{contact.first_name} #{contact.last_name}"
    puts "Email: #{contact.email}"
    puts "Notes: #{contact.note}"
    puts "Contact ID: #{contact.id}"
  end

  def add_new_contact
    puts "- - - - - - - - - - - - - -"
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
    contact = search_contact
    puts "Please enter new information:"
    print "Enter First Name: "
      contact.first_name = gets.chomp
    print "Enter Last Name: "
      contact.last_name = gets.chomp
    print "Enter Email Address: "
      contact.email = gets.chomp
    print "Enter a Note: "
     contact.note = gets.chomp
  end

  def delete_contact
    id_input = search_contact
    puts "Are you sure you would like to delete this contact?"
    puts "[1] Yes"
    puts "[2] No"
    user_select = gets.chomp.to_i

    if user_select == 1
      puts "Contact deleted"
      @rolodex.contacts.delete_at(id_input)

    elsif user_select == 2
      puts "Contact delete cancelled"
    end
  end

  def search_contact
    puts "- - - - - - - - - - - - - -"
    puts "Search:"
    puts "[1] By ID"
    puts "[2] By name"
    user_select = gets.chomp.to_i

    if user_select == 1
      print "Please enter ID now: "
      id_input = gets.chomp.to_i
      contact_selec = @rolodex.contacts[id_input]
      puts "You have selected:"
      contact_display(contact_selec)

    elsif user_select == 2
      print "Please enter first name now: "
      name_input = gets.chomp.to_s
      name_search = @rolodex.contacts.find do |contact| 
        if contact.first_name.downcase == name_input.downcase
          contact_selec = contact
          puts "You have selected:"
          contact_display(contact_selec)
        else
          puts "Your search did not match any names in our directory"
        end
      end
    end 
    contact_selec
  end

  def display_contacts
    puts "- - - - - - - - - - - - - -"
    puts "Full contact list:"
    @rolodex.contacts.each do |contact|
      contact_display(contact)
    end
  end

  def display_attributes
    puts "- - - - - - - - - - - - - -"
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


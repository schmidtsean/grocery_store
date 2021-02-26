# select multiple items to cart
# remove multiple items to cart
# qnty of items in store

@grocery_store = [
  {key:1, name: "Apple", price:2.5, qnty:3},
  {key:2, name: "Banana", price:5.9, qnty:3},
  {key:3, name: "Carrot", price:5.6, qnty:3},
  {key:4, name: "Tomato", price:3.4, qnty:3},
  {key:5, name: "Pork", price:12.5, qnty:3},
  {key:6, name: "Beef", price:14.5, qnty:3},
  {key:7, name: "Chicken", price:10.5, qnty:3}
]

@options = [
  {key:1, name: "View Store"},
  {key:2, name: "Add Item To Cart"},
  {key:3, name: "View Cart"},
  {key:4, name: "Checkout"},
  {key:5, name: "Remove Item"},
  {key:6, name: "Add Item To Store"},
  {key:7, name: "Exit"}
]

@cart = []
@wallet = [15]
 

def border
  puts
  puts "_" * 20
  puts
end

def display_options
  border
  @options.each_with_index do | option, index|
    puts " #{option[:key]}, #{option[:name]}"
  end
end

def view_cart
  border
  @cart.each_with_index do | grocery, index|
    puts "#{index +1}, Item:#{grocery[:name]}, $#{grocery[:price]}, Qnty #{grocery[:qnty]}"
  end
end

def view_store
  border
  @grocery_store.each_with_index do | grocery, index|
    puts "#{index +1}, Item:#{grocery[:name]}, $#{grocery[:price]}, Qnty #{grocery[:qnty]}"
  end
end




def add_item_to_cart
  basket = {}
  border
  puts "What Item Would You Like To Add To Cart?"
  view_store 
  selection = gets.chomp.to_i
  basket[:key] = @cart.length + 1
  basket[:name] = @grocery_store[selection -1][:name]
  basket[:price] = @grocery_store[selection -1][:price]
  
  @cart << basket 
  
  add_more_item
  
end

def add_more_item
  border
  puts "Would You Like To Add Another Item? (1.Yes 2.No)"
  border
  selection = gets.chomp.to_i
  case selection
  when 1
    add_item_to_cart
  when 2 
    display_menu
  else 
    puts "Invalid"
    display_menu
  end
end

def wallet
  total = 0.00
    @cart.each do |cart|              
        total += cart[:price].to_f    #not adding maybe cart not grocery?
    end
    if total > 15.0
        puts "You don't have enough money, please remove items and remain under $15."
        remove_item
    else 
      checkout
    end
  end

  #read through it, dont get lost with all the methods

def checkout
  border
  total = 0.00 
  @cart.each do | cart|
    total += cart[:price].to_f
  end
  puts "Your Total Is $#{total}"
  border
   puts "Would You Like To Apply A %10 OFF Coupon? (1. Yes 2. No)"
   selection = gets.chomp.to_i
    if selection == 1
    
      coupon
  
    elsif selection == 2
  
      no_coupon
    
    else
      "Invalid"
      checkout
    
    end 
  
  puts "Thank You! Come Again"
end
    
 def coupon 
  total = 0.00
  @cart.each do | cart|
    total += cart[:price].to_f
  end
        puts "Your cart cost is $#{total * 0.90}"
        puts "With tax, the total is $#{total * 0.90 + total * 0.06}"
   
  
 
    puts "Your Change Is $#{@wallet[0] - (total * 0.90 + total * 0.06)}"
  
    
end

def no_coupon
  total = 0.00
  @cart.each do | cart|
    total += cart[:price].to_f
  end
      puts "Your cart cost is $#{total}"
      puts "With tax, the total is $#{total + total * 0.06}"

  

    puts "Your Change Is $#{@wallet[0] - (total + total * 0.06)}"
 
end

def remove_item
  border
  puts "What Would You Like To Remove?"
  view_cart
  delete_item = gets.chomp.to_i
  @cart.delete_at(delete_item -1)
  view_cart
  remove_another_item
end

def remove_another_item
  border
  puts "Would You Like To Remove Another Item? (1.Yes 2.No)"
  border
  selection = gets.chomp.to_i
  case selection
  when 1
    remove_item
  when 2
    display_menu
  else
    puts "Invalid"
    display_menu
  end
end

def add_item_to_store
  border
  puts "What Is The Item?"
  new_name = gets.chomp
  border
  puts "What Is Item Price?"
  new_price = gets.chomp.to_f
  border
  puts "What Is Item Qnty?"
  new_qnty = gets.chomp.to_i
  new_item ={
    key: @grocery_store.length + 1,
    name: new_name,
    price: new_price,
    qnty: new_qnty
    
  }
  @grocery_store << new_item
end

def display_menu
  border
  puts "MENU"
  puts
  puts "You Have $15 In Your Wallet"
  
  display_options
  border
  choice = gets.chomp.to_i

  case choice
  when 1
    view_store
    display_menu
  when 2
    add_item_to_cart
    
  when 3
    view_cart
    display_menu
  when 4
    wallet
  when 5
    remove_item
    
  when 6
    add_item_to_store
    display_menu
  when 7
    puts "Thank You! Come Again!"
    exit
  else 
    puts "Invalid"
    display_menu
  end
end
 display_menu
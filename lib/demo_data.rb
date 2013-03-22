# encoding: utf-8

require 'factory_girl_rails'

module DemoData
  def self.load
    ActiveRecord::Base.transaction do
      load_users
      load_posts
    end
  end

  private

  def self.load_users
    FactoryGirl.create(:user,
                       first_name: 'Greg',
                       last_name: 'Salmon',
                       email: 'user1@example.com',
                       password: 'password',
                       password_confirmation: 'password')
    
    FactoryGirl.create(:user,
                       first_name: 'Andrew',
                       last_name: 'Ross',
                       email: 'user2@example.com',
                       password: 'password',
                       password_confirmation: 'password')

    FactoryGirl.create(:user,
                       first_name: 'Steve',
                       last_name: 'Nash',
                       email: 'user3@example.com',
                       password: 'password',
                       password_confirmation: 'password')
  end

  def self.load_posts
    andrew = User.where(first_name: 'Andrew').first
    steve = User.where(first_name: 'Steve').first
    

    post1 = FactoryGirl.create(:question,
                       title: "What was the significance of the Qamar Taj Dawlatabadi's travels?",
                       details: "I am writing a paper on the Dawlatabadi family history, and have
                       come across numerous interesting documents about them on the WWQI site.
                       Interestingly, Qamar Taj Dawlatabadi seems to have traveled a lot. I wanted
                       to know if anyone knows the purpose of her travels?",
                       tag_list: 'Moluk-al-saltaneh, Isfahan',
                       creator: andrew)
    FactoryGirl.create(:comment,
                       details: "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Vivamus vitae risus vitae lorem iaculis placerat. Aliquam sit amet felis. Etiam congue. Donec risus risus, pretium ac, tincidunt eu, tempor eu, quam. Morbi blandit mollis magna. Suspendisse eu tortor. Donec vitae felis nec ligula blandit rhoncus. Ut a pede ac neque mattis facilisis. Nulla nunc ipsum, sodales vitae, hendrerit non, imperdiet ac, ante. Morbi sit amet mi. Ut magna. Curabitur id est. Nulla velit. Sed consectetuer sodales justo. Aliquam dictum gravida libero. Sed eu turpis. Nunc id lorem. Aenean consequat tempor mi. Phasellus in neque. Nunc fermentum convallis ligula.",
                       commentable: post1,
                       user: steve)
  
    post2 = FactoryGirl.create(:discussion,
                               title: "Guess what I had for breakfast today.",
                               details: "Ok, guys. I woke up with such a headache. I think I'm 
                               suffering from amnesia because I can't even remember what I had for
                               breakfast today. What's your best guess?",
                               tag_list: 'breakfast, amnesia',
                               creator: steve)
    FactoryGirl.create(:comment,
                       details: "I'm guessing you had green eggs and ham. Am I close?",
                       commentable: post2,
                       user: andrew)
  end
end

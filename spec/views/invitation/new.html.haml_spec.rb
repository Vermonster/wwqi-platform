require 'spec_helper'

describe 'invitation/new.html.haml' do
  before do 
    invitation = FactoryGirl.build :invitation
    assign :invitation, invitation

    render
  end

  it 'displays a form to invite an unregistred user' do
    rendered.should have_selector('form',
                                  id: 'new_invitation',
                                  method: 'post',
                                  action: '/invitations') do |form|
      form.should have_selector('input', type: 'submit')
                                  end
  end

  it 'displays a field to enter a recipient email' do
    rendered.should have_selector('form', id: 'new_invitation') do |form|
      form.should have_selector('label', for: 'invitation_recipient_email')
      form.should have_selector('input',
                                type: 'text',
                                name: 'invitation[recipient_email]')
    end
  end

  it 'display a field to enter a recipient name' do
    rendered.should have_selector('form', id: 'new_invitation') do |form|
      form.should have_selector('label', for: 'invitation_recipient_name')
      form.should have_selector('input',
                                type: 'text',
                                name: 'invitation[recipient_name]')
    end
  end

  it 'displays a field to enter an invitaion message' do
    rendered.should have_selector('form', id: 'new_invitation') do |form|
      form.should have_selector('label', for: 'invitation_message')
      form.should have_selector('input',
                                type: 'textarea',
                                name: 'invitation[message]')
    end
  end

  it 'has a default message for the inviation message box' do
    rendered.should have_selector('form', id: 'new_invitation') do |form|
      form.should have_selector('input',
                                type: 'textarea',
                                name: 'invitation[message]',
                                value: 'default invitation message')
    end
  end
end

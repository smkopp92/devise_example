require 'spec_helper'

describe User do
  it { should have_valid(:first_name).when('Johnny', 'Suzy') }
  it { should_not have_valid(:first_name).when('', nil) }

  it { should have_valid(:last_name).when('Smith', 'Swanson') }
  it { should_not have_valid(:last_name).when('', nil) }

  it { should have_valid(:email).when('jon@example.com', 'user@gmail.com') }
  it { should_not have_valid(:email).when('desastr', nil, '') }

  it { should have_valid(:password).when('something', 'different') }
  it { should_not have_valid(:password).when(nil, '') }

  it 'is invalid when password and password confirmation do not match' do
    user = User.new
    user.password = 'password'
    user.password_confirmation = 'something else'
    expect(user).to_not be_valid
    expect(user.errors[:password_confirmation]).to_not be_blank
  end
end

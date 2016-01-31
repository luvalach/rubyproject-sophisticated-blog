User.create! :username => 'admin', :email => 'admin@test.cz', :password => 'admin123', :password_confirmation => 'admin123', :confirmed_at => Time.now

admin = User.find(1)
admin.add_role :admin

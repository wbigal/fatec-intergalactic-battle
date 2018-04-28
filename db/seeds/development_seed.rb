if Rails.env.development?
  print 'Creating users'

  print '.'
  User.create_with(name: 'Admin', password: '123@Mudar')
    .find_or_create_by(email: 'admin@fatecib.com.br')

  print " done (total: #{User.count})\n"
end

print 'Creating teams'

print '.'
Team.find_or_create_by(name: 'Time do Bem')
Team.find_or_create_by(name: 'Time do Mal')
print " done (total: #{Team.count})\n"

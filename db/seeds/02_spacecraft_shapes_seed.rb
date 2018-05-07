print 'Creating Spacecraft Shapes'

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-1x2.png')
  ),
  targets: [[0,0],[0,1]].to_json,
  spacecraft_width: 201,
  spacecraft_height: 98
).find_or_create_by(name: 'Modelo 1x2 - 210x98px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-1x3.png')
  ),
  targets: [[0,0],[0,1],[0,2]].to_json,
  spacecraft_width: 316,
  spacecraft_height: 98
).find_or_create_by(name: 'Modelo 1x3 - 316x98px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-2x2.png')
  ),
  targets: [
    [0,0],[0,2],
    [1,0],[1,1]
  ].to_json,
  spacecraft_width: 210,
  spacecraft_height: 198
).find_or_create_by(name: 'Modelo 2x2 - 210x198px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-cruz.png')
  ),
  targets: [
    [0,0],[0,2],
    [1,0],[1,1],[1,2],
    [2,0],[2,2]
  ].to_json,
  spacecraft_width: 316,
  spacecraft_height: 298
).find_or_create_by(name: 'Modelo Cruz - 316x298px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-L.png')
  ),
  targets: [
    [0,0],
    [1,0],
    [2,0],[2,1]
  ].to_json,
  spacecraft_width: 210,
  spacecraft_height: 298
).find_or_create_by(name: 'Modelo L - 201x298px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-Q.png')
  ),
  targets: [
    [0,0],[0,1],
    [1,0],[1,1],[1,2]
  ].to_json,
  spacecraft_width: 298,
  spacecraft_height: 210
).find_or_create_by(name: 'Modelo Q - 298x201px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-seta.png')
  ),
  targets: [
    [0,0],
    [1,0],[1,1],
    [2,0]
  ].to_json,
  spacecraft_width: 210,
  spacecraft_height: 298
).find_or_create_by(name: 'Modelo Seta - 210x298px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-seta2.png')
  ),
  targets: [
    [0,0],
    [1,0],[1,1],
    [2,0]
  ].to_json,
  spacecraft_width: 316,
  spacecraft_height: 298
).find_or_create_by(name: 'Modelo Seta2 - 316x298px')

print " done (total: #{SpacecraftShape.count})\n"

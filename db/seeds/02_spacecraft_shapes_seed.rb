print 'Creating Spacecraft Shapes'

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-1x2.png')
  ),
  targets: [[0,0],[0,1]].to_json,
  spacecraft_width: 100,
  spacecraft_height: 50
).find_or_create_by(name: 'Modelo 2x1 - 100x50px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-1x3.png')
  ),
  targets: [[0,0],[0,1],[0,2]].to_json,
  spacecraft_width: 150,
  spacecraft_height: 50
).find_or_create_by(name: 'Modelo 3x1 150x50px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-2x2.png')
  ),
  targets: [
    [0,0],[0,1],
    [1,0],[1,1]
  ].to_json,
  spacecraft_width: 100,
  spacecraft_height: 100
).find_or_create_by(name: 'Modelo 2x2 - 100x100px')

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
  spacecraft_width: 150,
  spacecraft_height: 150
).find_or_create_by(name: 'Modelo Cruz - 150x150px')

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
  spacecraft_width: 100,
  spacecraft_height: 150
).find_or_create_by(name: 'Modelo L - 100x150px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-Q.png')
  ),
  targets: [
    [0,0],[0,1],
    [1,0],[1,1],[1,2]
  ].to_json,
  spacecraft_width: 150,
  spacecraft_height: 100
).find_or_create_by(name: 'Modelo Q - 150x100px')

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
  spacecraft_width: 100,
  spacecraft_height: 150
).find_or_create_by(name: 'Modelo Seta - 100x150px')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes', 'modelo-seta2.png')
  ),
  targets: [
    [0,0],[0,1],
    [1,0],[1,1],[1,2],
    [2,0],[2,1]
  ].to_json,
  spacecraft_width: 150,
  spacecraft_height: 150
).find_or_create_by(name: 'Modelo Seta2 - 150x150px')

print " done (total: #{SpacecraftShape.count})\n"

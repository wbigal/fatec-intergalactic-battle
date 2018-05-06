print 'Creating Spacecraft Shapes'

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds',
                    'spacecraft_shapes', 'millennium-falcon-shape.png')
  ),
  targets: [
    [0,0],[0,1],[0,2],[0,3],
    [1,0],[1,1],[1,2],[1,3],[2,4],
    [2,0],[2,1],[2,2],[2,3],[2,4],
    [3,0],[3,1],[3,2],[3,3]
  ].to_json,
  spacecraft_width: 532,
  spacecraft_height: 402
).find_or_create_by(name: 'Millennium Falcon Shape')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds',
                    'spacecraft_shapes', 'caca-estrelar-x-wing-shape.png')
  ),
  targets: [
    [0,0],
    [1,0],[1,1],[1,2],
    [2,0]
  ].to_json,
  spacecraft_width: 320,
  spacecraft_height: 302
).find_or_create_by(name: 'Caça Estelar X-Wing Shape')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds',
                    'spacecraft_shapes', 'caca-tie-shape.png')
  ),
  targets: [
    [0,0],[0,2],
    [1,0],[1,1],[1,2],
    [2,0],[2,2]
  ].to_json,
  spacecraft_width: 320,
  spacecraft_height: 302
).find_or_create_by(name: 'Caça Tie Shape')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds',
                    'spacecraft_shapes', 'snowspeeder-shape.png')
  ),
  targets: [
    [0,0],[0,1],[0,2],
    [1,0],[1,1],[1,2],
    [2,0],[2,1],[2,2]
  ].to_json,
  spacecraft_width: 320,
  spacecraft_height: 302
).find_or_create_by(name: 'Snowspeeder Shape')

print '.'
SpacecraftShape.create_with(
  template: File.new(
    Rails.root.join('db', 'seeds', 'spacecraft_shapes',
                    'victory-II-class-star-destroyer-shape.png')
  ),
  targets: [
    [0,0],[0,1],[0,2],
    [1,0],[1,1],[1,2],[1,3],
    [2,0],[2,1],[2,2],[2,3],[2,4],
    [3,0],[3,1],[3,2],[3,3]
  ].to_json,
  spacecraft_width: 532,
  spacecraft_height: 402
).find_or_create_by(name: 'Victory II Class Star Destroyer Shape')

print " done (total: #{SpacecraftShape.count})\n"

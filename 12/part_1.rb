scan = "<x=3, y=-6, z=6>
<x=10, y=7, z=-9>
<x=-3, y=-7, z=9>
<x=-8, y=0, z=4>"

moons = scan
  .split("\n")
  .collect { |s| [
    s.match(/x=(.*),/)[1].to_i,
    s.match(/y=(.*),/)[1].to_i,
    s.match(/z=(.*)>/)[1].to_i,
    0,
    0,
    0,
  ]}

def apply_gravity moons
  i = 0
  while i < (moons.size - 1)
    j = i + 1
    while j < moons.size
      if moons[i][0] != moons[j][0]
        moons[i][3] += moons[i][0] < moons[j][0] ? 1 : -1
        moons[j][3] += moons[i][0] < moons[j][0] ? -1 : 1
      end
      if moons[i][1] != moons[j][1] 
        moons[i][4] += moons[i][1] < moons[j][1] ? 1 : -1
        moons[j][4] += moons[i][1] < moons[j][1] ? -1 : 1
      end
      if moons[i][2] != moons[j][2]
        moons[i][5] += moons[i][2] < moons[j][2] ? 1 : -1
        moons[j][5] += moons[i][2] < moons[j][2] ? -1 : 1
      end
      j+=1
    end
    i+=1
  end
  moons
end

def apply_velocity moons
  moons.collect {|moon| [
    moon[0] + moon[3],
    moon[1] + moon[4],
    moon[2] + moon[5],
    moon[3],
    moon[4],
    moon[5],
  ]}
end

def compute_energy moons
  energy = 0
  for moon in moons
    moon = moon.collect { |v| v.abs }
    pot = moon[0] + moon[1] + moon[2]
    kin = moon[3] + moon[4] + moon[5]
    energy += (pot * kin)
  end
  energy
end

for i in 1..1000
  moons = apply_gravity moons
  moons = apply_velocity moons
end

puts compute_energy moons

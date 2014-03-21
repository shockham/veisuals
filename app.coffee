# webgl mess about

# static vars
WIDTH = window.innerWidth
HEIGHT = window.innerHeight

VIEW_ANGLE = 45
ASPECT = WIDTH / HEIGHT
NEAR = 0.1
FAR = 1000

container = document.getElementById 'container'

renderer = new THREE.WebGLRenderer()

camera = new THREE.PerspectiveCamera VIEW_ANGLE, ASPECT, NEAR, FAR
camera.position.z = 300

scene = new THREE.Scene()


container.appendChild(renderer.domElement)

sphereMaterial = new THREE.MeshLambertMaterial { color: 0xCC00C0 }

radius = 50 
segments = 16
rings = 16

objs = []

for j in [0..3]
	for i in [0..5]
		mesh = new THREE.SphereGeometry radius, segments, rings	
		sphere = new THREE.Mesh mesh, sphereMaterial
		sphere.position.x = -250 + (i * 100)
		sphere.position.y = -200 + (j * 100)
		objs.push sphere
		scene.add sphere

pointLight = new THREE.PointLight 0xFFFFFF
pointLight.position.x = 10
pointLight.position.y = 50
pointLight.position.z = 130

scene.add camera
scene.add pointLight

renderer.setSize WIDTH, HEIGHT

render = () ->
	requestAnimationFrame render

	for ob in objs
		ob.rotation.x += (0.01 * Math.random())
		ob.rotation.y += (0.01 * Math.random())
		ob.rotation.z += (0.01 * Math.random())
		ob.geometry.verticesNeedUpdate = true
		for vert in ob.geometry.vertices
			vert.x = Math.tan(vert.z) * Math.random() * ob.position.x
			vert.y = Math.cos(vert.z) * Math.random() * ob.position.y

	renderer.render scene, camera

render()

 utility Grapes "Grapes creator"
(
spinner spLayerNum "Height :"  type:#integer range:[0,100,10]
spinner spGraperadius "Grape size :"  type:#float range:[0,50,10]
spinner spChaos "Chaos :"  type:#float range:[0,1,0.1]
spinner spDensity "Density :"  type:#float range:[0,1,0.7]
colorpicker cpGrapesColor "Grapes color : " type:#color color:[50, 155, 0]
button btnCreate "Create"
    
on btnCreate pressed  do
(

	layerNum = spLayerNum.value
	graperadius = spGraperadius.value
	chaos = spChaos.value
	density = spDensity.value
	grapesColor = cpGrapesColor.color
	--seed number for random values
	seed 25
	
	-- create the material for the grapes
	m = standard()
	m.diffuse = grapesColor
	m.shaderType = 5
	
	grapediagonal = graperadius*2
	
	
	for cirNum = 1 to layerNum do
	(
		
		circle_radius = 25+0.5*cirNum*graperadius
		
		--pieceOfGrapes = (2*circle_radius*pi) /(graperadius*2)
		--piece of grapes on one circle
		pieceOfGrapes = (circle_radius*pi) /(graperadius)
		degreeSeed = 360/pieceOfGrapes
		
		--down-->top
		--out-->in
		
		--go around the circles
		for angle = 0 to (360) by degreeSeed do
		(
			--more layer in circles
			for innerLayer=0 to (circle_radius/(grapediagonal)) do
			(
				ranDensity = random 0 100
					
				if ranDensity <= (density*100) then
				(
					ranX = random -chaos chaos
					ranY = random -chaos chaos
					ranZ = random -chaos chaos
					
					-- the distance from the center at the actual innerLayer
					innerLayerRadius = (circle_radius-(innerLayer*grapediagonal))
					--to make the grapes curly
					expDistorsion = ((layerNum-cirNum)*(layerNum-cirNum))/2
						
					x = (innerLayerRadius) * sin(angle)*(1+ranX) + expDistorsion
					y = (innerLayerRadius) * cos(angle)*(1+ranY) +expDistorsion
					z = grapediagonal*cirNum*(1+ranZ)
					sphere position:[x, y, z] radius:graperadius material:m
				)
			)
		)
	)
	
	--generate the "szár": material + cylinder
	m2 = standard()
	m2.diffuse = color 96 51 17
	m2.shaderType = 5
	cylinder position:[0,0,(grapediagonal*layerNum)] height: ((grapediagonal*layerNum)*0.25) radius:(graperadius*0.5) material:m2

)
)
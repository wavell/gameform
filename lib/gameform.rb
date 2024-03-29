require 'RMagick'
class NormalForm
  
  # # makes a skyblue box with hello in it
  # convert -size 100x60 xc:skyblue -fill white -stroke black -font Candice -pointsize 40 -gravity center -draw "text 0,0 'Hello'"  draw_text.gif
  # 
  # # make a rectangle with white fill on skyblue background
  # convert -size 100x60 xc:skyblue -fill white -stroke black -draw "rectangle 20,10, 80,50" draw_rect.gif
  def draw_rectangle (location=File.dirname(__FILE__) + "/../examples/")
    # debugger
    canvas = Magick::Image.new(240, 300,
                  Magick::HatchFill.new('white','lightcyan2'))
    
    myrectangle = Magick::Draw.new
  	myrectangle.fill('white')
    myrectangle.stroke('black')
    myrectangle.rectangle 20, 10, 80, 50
    myrectangle.draw(canvas)
    canvas.write(location + 'rectangle.gif')
    
  end
  # 
  # # draw a line
  # convert -size 100x60 xc:skyblue -fill white -stroke black -draw "line   20,50 90,10" draw_line.gif
  def draw_line(canvas = Magick::Image.new(240, 300,
                            Magick::HatchFill.new('white','lightcyan2')),
                   args={first_x: 20,
                     first_y: 50,
                     second_x: 90,
                     second_y: 10},
                     location=File.dirname(__FILE__) + "/../examples/")
                   
        
    myline = Magick::Draw.new
    myline.fill('white')
    myline.stroke('black')
    myline.line args[:first_x], args[:first_y], args[:second_x],args[:second_y]
    myline.draw(canvas)
    canvas.write(location + 'line.gif')
      
  end
	
	# convert -size 100x60 xc:skyblue -fill white -stroke black -font Candice -pointsize 40 -gravity center -draw "text 0,0 'Hello'"  draw_text.gif
	def draw_annotation(location=File.dirname(__FILE__) + "/../examples/")
    # canvas = Magick::Image.new(240, 300,
    #                 Magick::HatchFill.new('white','lightcyan2'))
    
	  canvas = Magick::Image.new(300, 50) do
        self.background_color = 'none'
    end
  
    myannotation = Magick::Draw.new
		myannotation.fill('black')
    myannotation.stroke('black')
    myannotation.font "Courier-New-Regular"
    myannotation.pointsize 24
    myannotation.gravity Magick::CenterGravity
    myannotation.text 0, 0, 'Hello'
    myannotation.draw(canvas)
    canvas.rotate!(45)
    canvas.write(location + 'annotation.gif')
  end

	def draw_label_image(label_text='Football',
                   args={width: 100,
                     height: 15},
                     location=File.dirname(__FILE__) + "/../examples/")  
       
                  
	  strategy_canvas = Magick::Image.new(args[:width], args[:height]) do
        self.background_color = 'none' # change this to none later
    end
		
   # label_text = "Football"
   # label = Magick::Draw.new
   # label.font = "Courier-New" # use courier-new for windows and courier for mac
   # label.text_antialias(true)
   # label.font_style=Magick::NormalStyle
   # label.font_weight=Magick::BoldWeight
   # label.gravity=Magick::EastGravity
   # label.text(0,0,label_text)
   # metrics = label.get_type_metrics(label_text)
   # width = metrics.width
   # height = metrics.height
    # debugger
		width, height, label = draw_label label_text
  	label.draw(strategy_canvas)
  	strategy_canvas.write(location + 'label.gif')
    [width, height, strategy_canvas]
  end

	def draw_label(label_text='Football')  
    label = Magick::Draw.new
    label.font = "Courier-New" # use courier-new for windows and courier for mac
    label.text_antialias(true)
    label.font_style=Magick::NormalStyle
    label.font_weight=Magick::BoldWeight
    label.gravity=Magick::EastGravity
    label.text(0,0,label_text)
    metrics = label.get_type_metrics(label_text)
    width = metrics.width
    height = metrics.height
    # debugger
    [width, height, label]
  end
  
  def draw_foursquare(location=File.dirname(__FILE__) + "/../examples/")
    
    canvas_coordinates={}
    canvas_coordinates[:width]=240
    canvas_coordinates[:height]=300
    
    rectangle_coordinates={}
    rectangle_coordinates[:first_horizontal]=20
    rectangle_coordinates[:first_vertical]=10
    rectangle_coordinates[:second_horizontal]=80
    rectangle_coordinates[:second_vertical]=50
    
    vertical_line={}
    vertical_line[:first_vertical]=rectangle_coordinates[:first_vertical]
    vertical_line[:first_horizontal] = (rectangle_coordinates[:first_horizontal]+
      rectangle_coordinates[:second_horizontal])/2
    vertical_line[:second_vertical]=rectangle_coordinates[:second_vertical]
    vertical_line[:second_horizontal]=vertical_line[:first_horizontal]
    
    horizontal_line={}
    horizontal_line[:first_vertical]=(rectangle_coordinates[:first_vertical]+
      rectangle_coordinates[:second_vertical])/2
    
    horizontal_line[:first_horizontal] = rectangle_coordinates[:first_horizontal]
    horizontal_line[:second_vertical]=horizontal_line[:first_vertical]
    horizontal_line[:second_horizontal]=rectangle_coordinates[:second_horizontal]
    
      
    canvas = Magick::Image.new(canvas_coordinates[:width], 
                              canvas_coordinates[:height],
                              Magick::HatchFill.new('white','lightcyan2'))
    
    myfoursquare = Magick::Draw.new
  	myfoursquare.fill('white')
    myfoursquare.stroke('black')
    myfoursquare.rectangle rectangle_coordinates[:first_horizontal], 
                           rectangle_coordinates[:first_vertical], 
                           rectangle_coordinates[:second_horizontal], 
                           rectangle_coordinates[:second_vertical]
    myfoursquare.line vertical_line[:first_horizontal], 
                      vertical_line[:first_vertical], 
                      vertical_line[:second_horizontal], 
                      vertical_line[:second_vertical]                      
    myfoursquare.line horizontal_line[:first_horizontal], 
                      horizontal_line[:first_vertical], 
                      horizontal_line[:second_horizontal], 
                      horizontal_line[:second_vertical] 
    myfoursquare.draw(canvas) 
    canvas.write(location + 'foursquares.gif')
    
  end
 
 
  # def some_method (thing, options)
  #   options.reverse_merge!({:key1 => 'default'})
  #    puts thing
  #    puts options
  # end
  def draw_annotated_game(location=File.dirname(__FILE__) + "/../examples/")
    
    canvas_coordinates={}
    canvas_coordinates[:width]=240
    canvas_coordinates[:height]=300
    
		# TODO: take grid out when done
    canvas = Magick::Image.new(canvas_coordinates[:width], 
                              canvas_coordinates[:height],
                              Magick::HatchFill.new('white','lightcyan2'))
    
    topleft_adjustment = 50
    bottomright_adjustment = 140
    rectangle_coordinates={}
    
    # rip out the line drawing
    
    rectangle_coordinates[:first_horizontal]=20 + topleft_adjustment
    # First_vert = first_horiz/2
    rectangle_coordinates[:first_vertical]=10 + topleft_adjustment
    rectangle_coordinates[:second_horizontal]=80 + bottomright_adjustment
    # second_vert = second_horiz *.625
    rectangle_coordinates[:second_vertical]=50 + bottomright_adjustment
     #     
     vertical_line={}
        vertical_line[:first_vertical]=rectangle_coordinates[:first_vertical]
        vertical_line[:first_horizontal] = (rectangle_coordinates[:first_horizontal]+
          rectangle_coordinates[:second_horizontal])/2
        vertical_line[:second_vertical]=rectangle_coordinates[:second_vertical]
        vertical_line[:second_horizontal]=vertical_line[:first_horizontal]
    
    # debugger
    draw_line canvas, {first_x: vertical_line[:first_horizontal],
                   first_y: vertical_line[:first_vertical],
                   second_x: vertical_line[:second_horizontal],
                   second_y: vertical_line[:second_vertical]}
    # draw_line canvas, {first_x: vertical_line[:first_horizontal], first_y: vertical_line[:first_vertical], second_x: vertical_line[:second_horizontal],  second_y: vertical_line[:second_vertical]}
    # debugger
    # draw_line canvas, {first_x: 20, first_y: 10, second_x: 80, second_y: 50}
    
    horizontal_line={}
    horizontal_line[:first_vertical]=(rectangle_coordinates[:first_vertical]+
      rectangle_coordinates[:second_vertical])/2
    
    horizontal_line[:first_horizontal] = rectangle_coordinates[:first_horizontal]
    horizontal_line[:second_vertical]=horizontal_line[:first_vertical]
    horizontal_line[:second_horizontal]=rectangle_coordinates[:second_horizontal]
    
    draw_line canvas, {first_x: horizontal_line[:first_horizontal],
                   first_y: horizontal_line[:first_vertical],
                   second_x: horizontal_line[:second_horizontal],
                   second_y: horizontal_line[:second_vertical]}
    
    myfoursquare = Magick::Draw.new
  	myfoursquare.fill('none')
    myfoursquare.stroke('black')
    myfoursquare.rectangle rectangle_coordinates[:first_horizontal], 
                           rectangle_coordinates[:first_vertical], 
                           rectangle_coordinates[:second_horizontal], 
                           rectangle_coordinates[:second_vertical]
    # myfoursquare.line vertical_line[:first_horizontal], 
    #                    vertical_line[:first_vertical], 
    #                    vertical_line[:second_horizontal], 
    #                    vertical_line[:second_vertical]                      
    # myfoursquare.line horizontal_line[:first_horizontal], 
    #                         horizontal_line[:first_vertical], 
    #                         horizontal_line[:second_horizontal], 
    #                         horizontal_line[:second_vertical] 
    # myfoursquare.annotate canvas, 100, 100, 20, 50, "Football"
    #20 10 80 50
    # need to figure out the total pointsize of the text
    # maybe pointsize * size of text?
		#replace this is draw label
    # strategy_label= "Football" 
    # debugger
		# have to draw and then redraw to get length
		label_width, label_height = draw_label "Football"
    label_width, label_height, label_canvas = 
						draw_label_image "Football", width: label_width, height: label_height
		label_canvas= label_canvas.rotate 45
		
    text_coordinates = {}  
    text_coordinates[:pointsize] = 15
    # there is no way strategy size is 120 *and* size of rectangle is 130
    # strategy_size= text_coordinates[:pointsize] * strategy_label.size
		strategy_size= label_width
    # was 90
    # rotated text should *end* at 1/2 of 1/2 the length of the box 
    # and a little higher horizontally
    # this means rotated text should *start* at 
    # label_size - (1/2 of 1/2 of horizontal length) * 1/2 of label size
    # (because of 45 degree rotation)
    # and vertically 1/2 label_size higher than horizontal
    # debugger
		# calc lengths and then add horiz and vert offsets
    # debugger
    rectangle_width = rectangle_coordinates[:second_horizontal] - 
                          rectangle_coordinates[:first_horizontal]
		# vertical size of 45 degrees rotated text is 1/2 size of text
		#   plus 1/2 height of text.
		label_buffer = 10
    text_rotated_vertical_offset_from_center = 
						(0.50 * strategy_size) + (0.50 * label_height) + label_buffer
						#strategy_size - ((0.25 * strategy_size) + (0.50 * strategy_size))
    text_coordinates[:text_vertical] = rectangle_coordinates[:first_vertical] - 
                                        text_rotated_vertical_offset_from_center
    # debugger
		# roated label width = 50% of the width. 
		rotated_strategy_size = 0.50 * strategy_size
		# we want to start 1/2 way between one of the strategy columns
		# that means 50% of 50% (25%) of the column length - the horizontal
		# start of the column 
    column_length = 0.50 * rectangle_width # only two columns right now 
    center_column_offset = 0.50 * column_length
    text_rotated_horizontal_offset_from_center = rectangle_coordinates[:first_horizontal] +
                          center_column_offset - rotated_strategy_size
																								
    # was 20                        
    text_coordinates[:text_horizontal] = text_rotated_horizontal_offset_from_center 
    # text = Magick::Draw.new
    # text.font "Courier-New"
    # text.pointsize = 15
    # text.pointsize = text_coordinates[:pointsize]
    # text.gravity = Magick::CenterGravity
    # maybe try to do a fixed length and height of the text (geometry?) and
    # then right-justify with gravity.
    # I guess annotate is supposed to have height/width as well ...
    # looks like I'm supposed to use a label, size it, have it 'best fit',
    # then compose that labels canvas onto images canvas I want
		# debugger
		canvas.composite!(label_canvas, text_coordinates[:text_horizontal],
																		text_coordinates[:text_vertical],
																		Magick::OverCompositeOp)
    # text.annotate(canvas, 0,0,text_coordinates[:text_horizontal],
                            # text_coordinates[:text_vertical],
                             # strategy_label) {
       # self.font "Courier-New-Regular"
       # self.fill = 'gray40'
       # self.rotation = 45
    # }
    
    
    
    myfoursquare.draw(canvas)  
    canvas.write(location + 'annotatedgame.gif')    
      #   
      #     canvas = Magick::Image.new(300, 50) do
      #         self.background_color = 'none'
      #     end
      #   
      #     myannotation = Magick::Draw.new
      # myannotation.fill('black')
      #     myannotation.stroke('black')
      #     myannotation.font "Arial"
      #     myannotation.pointsize 25
      #     myannotation.gravity Magick::CenterGravity
      #     myannotation.text 0, 0, 'Hello'
      #     myannotation.draw(canvas)
      #     canvas.rotate!(45)
      #     canvas.write(location + 'annotation.gif')
    
  end
 
  def draw_game(column=2, rows=2,
                   args={width: 240,
                     height: 300},
                     location=File.dirname(__FILE__) + "/../examples/")
                     
     canvas = Magick::Image.new(args[:width], 
                                 args[:height],
                                 Magick::HatchFill.new('white','lightcyan2'))
     # debugger                           
     game_info = get_coordinates(2,2, {first_horizontal: 70,
                                        first_vertical: 60,
                                        second_horizontal: 220,
                                        second_vertical: 190} )                                  
  end
  
  def get_coordinates(columns=2, rows=2,
                        rectangle_coordinates={first_horizontal: 70,
                                              first_vertical: 60,
                                              second_horizontal: 220,
                                              second_vertical: 190})
                                              
    # get rectangle width/height
    # get offset (rectange width/height - respective coordinates)
    # get proportionate columns/rows
    # use fractions and right-most/bottom-most side as the whole
    # e.g for a rectange with three columns the right-most side would be 3/3
    # of the rectangle width while the first and second columns would be 
    # 1/3 and 2/3 of the recangle width, respectively
    # of course all columns should be equal width and height, so after calculating
    # just one you should have all, and then just use the offset * column number
    # to get the coordinates                                          
    game_info = {}                            
    game_info[:rectangle_width] = rectangle_coordinates[:second_horizontal] - 
                          rectangle_coordinates[:first_horizontal]  
    game_info[:rectangle_height] = rectangle_coordinates[:second_vertical] - 
                          rectangle_coordinates[:first_vertical]  
                           
    vertical_lines ||=[]                                     
    vertical_line={}
    vertical_line[:first_vertical]=rectangle_coordinates[:first_vertical]
    vertical_line[:first_horizontal] = (rectangle_coordinates[:first_horizontal]+
                                      rectangle_coordinates[:second_horizontal])/2
    vertical_line[:second_vertical]=rectangle_coordinates[:second_vertical]
    vertical_line[:second_horizontal]=vertical_line[:first_horizontal]
    vertical_lines.push vertical_line  
 
    horizontal_lines ||=[]          
    horizontal_line={}
    horizontal_line[:first_vertical]=(rectangle_coordinates[:first_vertical]+
                                      rectangle_coordinates[:second_vertical])/2
    horizontal_line[:first_horizontal] = rectangle_coordinates[:first_horizontal]
    horizontal_line[:second_vertical]=horizontal_line[:first_vertical]
    horizontal_line[:second_horizontal]=rectangle_coordinates[:second_horizontal] 
    horizontal_lines.push horizontal_line
        
    game_info[:vertical_lines]=vertical_lines 
    # get the info for the column just before a vertical line and just before the right side
    # of the rectangle
    column_infos||=[]
    column_info = {}
    # debugger
    vertical_lines.each do |line|
      if column_infos.count == 0
        column_info[:begin] = rectangle_coordinates[:first_horizontal]
      else
        column_info[:begin] = column_infos.last[:end]
      end
      column_info[:end]=line[:first_horizontal]
      column_infos.push column_info
    end
    # add column info for the last line (right side)
    if column_infos.count == 0
      column_info[:begin] = rectangle_coordinates[:first_horizontal]
    else
      column_info[:begin] = column_infos.last[:end]
    end
    column_info[:end]= rectangle_coordinates[:second_horizontal]
    column_info[:width]= column_info[:end] - column_info[:begin]
    column_infos.push column_info
      
    game_info[:horizontal_lines]=horizontal_lines
    # add row code here
    # maybe make a get_row_info function
    # get the info for the row just above a horizontal line and just above the bottom 
    # of the rectangle
    game_info[:columns]=column_infos
    game_info                                     
  end
  
  def lolcat

    img = ImageList.new('public/computer-cat.jpg')
    txt = Draw.new
    img.annotate(txt, 0,0,0,0, "In ur Railz, annotatin ur picz."){
    txt.gravity = Magick::SouthGravity
    txt.pointsize = 25
    txt.stroke = '#000000'
    txt.fill = '#ffffff'
    txt.font_weight = Magick::BoldWeight
    }
    
    img.format = 'jpeg'
    send_data img.to_blob, :stream => 'false', :filename => 'test.jpg', :type => 'image/jpeg', :disposition => 'inline'

	end
	
end
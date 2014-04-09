#!/usr/bin/env ruby

require 'RMagick'
include Magick

name = " @ANDREW"
location = "LONDON"

overlay = ImageList.new("runwithme.png")
overlay.alpha(Magick::ActivateAlphaChannel)
overlay.background_color = "none"
overlay.opacity = Magick::MaxRGB/8

text_canvas = Magick::Image.new(overlay.columns, overlay.rows) do |c|
  c.background_color= "Transparent"
end

text_canvas.alpha(Magick::ActivateAlphaChannel)

name_text = Magick::Draw.new
name_text.gravity = Magick::WestGravity
name_text.pointsize = 32
name_text.font_family = "Helvetica"
name_text.font_weight = Magick::BoldWeight
name_text.fill = "#6affff"
name_text.annotate(text_canvas, 100, 250, 10, 0, name)

location_text = Magick::Draw.new
location_text.gravity = Magick::EastGravity
location_text.pointsize = 32
location_text.font_family = "Helvetica"
location_text.font_weight = Magick::BoldWeight
location_text.fill = "#6affff"
location_text.annotate(text_canvas, 100, 250, -500, 0, location)

#overlay.composite!(text_canvas, Magick::CenterGravity, Magick::OverCompositeOp)
#overlay.composite!(text_canvas, Magick::CenterGravity, Magick::ColorizeCompositeOp)
overlay.composite!(text_canvas, Magick::CenterGravity, Magick::AtopCompositeOp)

text_canvas.alpha(Magick::ActivateAlphaChannel)

images = ImageList.new(*Dir["images/*.jpg"])

images.map! do |image|
  image.resize!(620,518)
  #image.composite!(overlay, 0, 180,  Magick::OverCompositeOp)
  image.composite!(overlay, 0, 180,  Magick::AtopCompositeOp)
end

images.delay = 100
images.write("animated.gif")


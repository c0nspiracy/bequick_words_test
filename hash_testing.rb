h = {"arro"=>["arrow", "carrot", "Sparrow"], "rrow"=>["arrow", "Sparrow"], "carr"=>["carrot"], "rrot"=>["carrot"], "Spar"=>["Sparrow"], "parr"=>["Sparrow"]}
puts h.select {|k,v| v.length == 3}

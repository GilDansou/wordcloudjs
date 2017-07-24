HTMLWidgets.widget({

  name: 'wordcloudjs',

  type: 'output',

  factory: function(el, width, height) {

    // TODO: define shared variables for this instance
    // TODO: code to render the widget, e.g.


    return {

      renderValue: function(x) {



        if(typeof(el.chart) == 'undefined'){

              var canvasString = '<div id="'+el.id+'_myCanvasContainer" class = "myCanvasContainer" style = "width:100%;height:100%;"><canvas id="'+el.id+'_myCanvas"><p>Anything in here will be replaced on browsers that support the canvas element</p></canvas> </div>';
              el.innerHTML = canvasString;


              var node = document.createElement("div");
              node.id = el.id+'_tags';
              node.className = 'canvastags';
              node.innerHTML = x.words;

              el.appendChild(node);

              var id_canvas = el.id+"_myCanvas";
              var id_node = el.id+"_tags";

              var canvas_style = el.childNodes[0].childNodes[0];

              canvas_style.width = el.clientWidth;
              canvas_style.height = el.clientHeight;

              var options = x.options;

              TagCanvas.Start(id_canvas,id_node,options);

              if(x.setspeed == true){
                TagCanvas.SetSpeed(id_canvas, [0.5, -0.25]);
              }

              document.getElementById(id_node).style.visibility = "hidden";
              localStorage.setItem(id_canvas, JSON.stringify(options));



        }else{
              var id_canvas = el.id+"_myCanvas";
              TagCanvas.Update(id_canvas);
        }

      },

      resize: function(width, height) {

      }

    };
  }
});

<template>
  <div id="my_dataviz"/>
  <!-- <div class="kaizten-container-scenario" /> -->
</template>


<!-- Create a div where the graph will take place -->


<!-- Create a div where the graph will take place -->

<script>

  import * as d3 from 'd3'

  export default {
    name: 'D3component',

    data () {
        return {
            chart: null,
        }
    },

    props: {
      myData: Object
    },

    methods: {

      drawChart() {

        // set the dimensions and margins of the graph
        var margin = {top: 10, right: 30, bottom: 30, left: 60},
            width = 460 - margin.left - margin.right,
            height = 400 - margin.top - margin.bottom;

        //var svg = d3.select(this.chart)
        // append the svg object to the body of the page
        var svg = d3.select("#my_dataviz")
          .append("svg")
            .attr("width", width + margin.left + margin.right)
            .attr("height", height + margin.top + margin.bottom)
          .append("g")
            .attr("transform",
                  "translate(" + margin.left + "," + margin.top + ")");

        /*d3.csv("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered_comma.csv")
            .then(function(data) {
                console.log(data);
            })*/
        //Read the data
        d3.csv("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered_comma.csv",

          // When reading the csv, I must format variables:
          this.computeData,

          // Now I can use this dataset:
          function(data) {

            // Add X axis --> it is a date format
            var x = d3.scaleTime()
              .domain(d3.extent(data, function(d) { return d.date; }))
              .range([ 0, width ]);
            svg.append("g")
              .attr("transform", "translate(0," + height + ")")
              .call(d3.axisBottom(x));

            // Add Y axis
            var y = d3.scaleLinear()
              .domain([0, d3.max(data, function(d) { return +d.value; })])
              .range([ height, 0 ]);
            svg.append("g")
              .call(d3.axisLeft(y));
            
            svg.append("path")
              .datum(data)
              .attr("fill", "none")
              .attr("stroke", "steelblue")
              .attr("stroke-width", 1.5)
              .attr("d", d3.line()
                .x(function(d) { return x(d.date) })
                .y(function(d) { return y(d.value) })
                )

        })
      },
      computeData(d) {
        return { 
            date : d3.timeParse("%Y-%m-%d")(d.date), 
            value : d.value 
        }
      }
    },

    mounted() {
      this.chart = this.$el
      this.drawChart();
    },
  }
</script>

<style scoped>
/* SVG */
>>> svg {
    background-color: orange;
}

>>> path {
    stroke: steelblue;
    fill: none;
    stroke-width: 1.5;
}
</style>
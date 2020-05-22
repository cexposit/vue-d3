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
            svg: null,
            gx: null,
            gy: null,
            width: null,
            height: null,
        }
    },

    props: {
      myData: Object
    },

    methods: {

      drawChart() {
        // set the dimensions and margins of the graph
        var margin = {top: 10, right: 30, bottom: 30, left: 60}
        this.width = 460 - margin.left - margin.right,
        this.height = 400 - margin.top - margin.bottom;

        //var svg = d3.select(this.chart)
        // append the svg object to the body of the page
        this.svg = d3.select("#my_dataviz")
          .append("svg")
            .attr("width", this.width + margin.left + margin.right)
            .attr("height", this.height + margin.top + margin.bottom)
          .append("g")
            .attr("transform",
                  "translate(" + margin.left + "," + margin.top + ")");

        /*d3.csv("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered_comma.csv")
            .then(function(data) {
                console.log(data);
            })*/
        //Read the data
        let positions = []
        positions.push({
          x: 0,
          y: 0,
        })
        positions.push({
          x: 10,
          y: 10,
        })
        positions.push({
          x: 20,
          y: 15,
        })
        positions.push({
          x: 30,
          y: 25,
        })
        this.myFunc(positions)


        /*d3.csv("https://raw.githubusercontent.com/holtzy/data_to_viz/master/Example_dataset/3_TwoNumOrdered_comma.csv",

          // When reading the csv, I must format variables:
          this.computeData,

          // Now I can use this dataset:
          this.myFunc
        )*/
      },
      computeData(d) {
        return { 
            date : d3.timeParse("%Y-%m-%d")(d.date), 
            value : d.value 
        }
      },
      myFunc (data) {
        this.gx = d3.scaleTime()
              .domain(d3.extent(data, function(d) { return d.date; }))
              .range([ 0, this.width ]);
        this.svg.append("g")
              .attr("transform", "translate(0," + this.height + ")")
              .call(d3.axisBottom(this.gx));

            // Add Y axis
        this.gy = d3.scaleLinear()
              .domain([0, d3.max(data, function(d) { return +d.value; })])
              .range([ this.height, 0 ]);
        this.svg.append("g")
              .call(d3.axisLeft(this.gy));

        let lineGenerator = d3.line()
            .x(function(d) { return d.x })
            .y(function(d) { return d.y })

        console.log(data)
            
        this.svg.append("path")
              .datum(data)
              .attr("fill", "none")
              .attr("stroke", "black")
              .attr("stroke-width", "1px")
              .attr('d', lineGenerator)

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
import Chart from 'chart.js';

document.addEventListener("DOMContentLoaded", function() {
  var ctx = document.getElementById('lifeCycleChart').getContext('2d');
  var startTimes = JSON.parse(document.getElementById('lifeCycleChart').getAttribute('data-start-times'));
  var endTimes = JSON.parse(document.getElementById('lifeCycleChart').getAttribute('data-end-times'));

  var labels = ['sleeping', 'work', 'enjoying', 'study', 'meal', 'others'];
  var data = [];

  for (var i = 0; i < labels.length; i++) {
    var startTimeCounts = countTime(startTimes, labels[i]);
    var endTimeCounts = countTime(endTimes, labels[i]);
    var timeCounts = mergeTimeCounts(startTimeCounts, endTimeCounts);
    data.push(sumTimeCounts(timeCounts));
  }

  var myChart = new Chart(ctx, {
    type: 'doughnut',
    data: {
      labels: labels,
      datasets: [{
        data: data,
        backgroundColor: [
          'rgba(255, 99, 132, 0.8)',
          'rgba(54, 162, 235, 0.8)',
          'rgba(255, 206, 86, 0.8)',
          'rgba(75, 192, 192, 0.8)',
          'rgba(153, 102, 255, 0.8)',
          'rgba(255, 159, 64, 0.8)'
        ],
        borderColor: [
          'rgba(255, 99, 132, 1)',
          'rgba(54, 162, 235, 1)',
          'rgba(255, 206, 86, 1)',
          'rgba(75, 192, 192, 1)',
          'rgba(153, 102, 255, 1)',
          'rgba(255, 159, 64, 1)'
        ],
        borderWidth: 1
      }]
    },
    options: {
      responsive: true,
      legend: {
        position: 'bottom',
        labels: {
          fontColor: 'black'
        }
      }
    }
  });

  function countTime(times, label) {
    return times.filter(function(time) {
      return time === label;
    }).length;
  }

  function mergeTimeCounts(startTimeCounts, endTimeCounts) {
    var timeCounts = [];

    for (var i = 0; i < startTimeCounts.length; i++) {
      timeCounts.push(startTimeCounts[i] + endTimeCounts[i]);
    }

    return timeCounts;
  }

  function sumTimeCounts(timeCounts) {
    return timeCounts.reduce(function(acc, val) {
      return acc + val;
    });
  }
});

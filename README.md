# problem-set-7-jackmschroeder-olivercordeiro

This is the seventh problem set for Gov 1005: Data.

It is the work of Jack Schroeder and Oliver Cordeiro.

Some notes:

(1) Given all the slack polling is getting these days with failing to properly sample and weigh their respsective populations, we were expecting a strong correlation between the two variables. Instead, the correlation between margin of error and outlier percentage was -0.1437853. This is not statistically significant, and shows that the model was largely correct in weighing its respondents.

(2) The correlation among Democratic flips was 0.05736348. This implies that The Upshot was very precise in weighing outliers in districts that actually flipped.

(3) The correlation among Republican holds was -0.2637483. This is a very weak correlation, but it demonstrates that the largest fault in The Upshot's model was over-emphasizing Democrat-leaning outliers in Republican incumbent districts.

(4) There were not enough polled results to calculate meaningful correlations for Republican flips and Democratic holds.

(5) UT-04 is still yet to be officially called, but is looking like a Republican hold. Our data reflect that.

(6) Our outlier percentage is based on all available polls for each district in order to get an accurate tally of Upshot outliers. However, when calculating margin of error, we used only the most recent poll in each district. We did this because within each district, the percentage of outliers is not dependent on time, but the forecasted margin of error is.

(7) The datasets for flips and results were updated for newly called races, but the vote totals were left as they were as of November 9th.
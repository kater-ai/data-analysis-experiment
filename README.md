![https://www.kater.ai/](/assets/image/banner.jpg)

# [Kater](https://www.kater.ai/) LLM Data Analysis Experiment

This experiment seeks to test how accurate and useful the most popular and powerful LLM's are at analyzing a table of 
data which is fed to them.

Each LLM will be prompted to find ten trends in a csv dataset, given the dataset and an explanation of each column of the table.
The responses will be scored based on the number of correct data points, as well as the usefulness of the response. The scoring scale 
of the usefulness of the response will be as follows:
```
1. Not Useful 1 point
2. Somewhat Useful 2 points
3. Useful 3 points
```

The usefulness of the response is somewhat subjective, but we've decided to use our best judgement here based on if we think the response provides valuable insights to an analyst.

#### We will be comparing the following LLM's
```
1. Gemini 1.5
2. GPT 4 Turbo
3. Claude 3
```

**Update**: We found that the responses varied widely in correctness so as an additional measure we attempted to have the LLMs generate vega-lite graphs instead and analyze those

**For all of the models listed we will be using a temperature of 0.3 a Top K of 50 and a Top P of 1.**

The datasets are all pulled from the open source microsoft [AdventureWorksDW2022](https://learn.microsoft.com/en-us/sql/samples/adventureworks-install-configure?view=sql-server-ver16&tabs=ssms) sample data warehouse

The project is structured as follows:
- data: All of the csv sample sets can be found here for the ten test cases
- metadata: The snowflake schema metadata for each of the datasets
- <LLM_NAME>: This contains the LLM's output for every run, there is an additional <LLM_NAME>/graphs folder in which we store the graphs we asked the LLM to generate in vega-lite format
- analysis_prompt.j2: this the base prompt we use for all ten test cases. We add the data set and prompt context to this to run the experiment.
- generate_graph_prompt.j2: The prompt used to generate the graphs from the table metadata.
- graph_insights_prompt.txt: The prompt used to generate the vega-lite graphs
- sql: This folder includes the ten business questions which the test datasets came from as well as the sql used to retrieve the datasets.
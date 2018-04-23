<h2 id="std-param">Standard Headers</h2>

Current valid version number(s): 1, 2

<h2 id="std-errors">Error Handling</h2>

Error responses will use the appropriate 4xx HTTP error codes. All
errors come with a standard JSON response:

    {
      "errors": [
        // Error message strings...
      ]
    }

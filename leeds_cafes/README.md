# Post Code Challenge
## Description
This app takes data from Leeds and organizes it into categories and performs calculations on it.
## Notes
Some how every time I named the table 'street_cafes', ActiveRecord would look for 'street_caves' and nothing would function properly, so I renamed the table to 'restaurants'.
This is my first time testing rake tasks and I haven't figured out what it is about the random order of tests that sometimes causes two of the rake task tests to fail.
## Setup
```Ruby
bundle install
rake db:create
rake db:migrate
rake import:cafe_data
rake category:remove_small_cafes
rake category:rename_cafes
```
## Next Steps
Refactor the update methods into a module or rake task.
Nail down rake task tests.
## Specifications
### Testing
RSpec
### Tech Stack
Ruby on Rails
## Checklist
[x] This requires Postgres (9.4+) & Rails(4.2+), so if you don't already have both installed, please install them.

[x] Download the data file from: https://github.com/gospotcheck/ps-code-challenge/blob/master/Street%20Cafes%202015-16.csv

[x] Add a varchar column to the table called category.

Create a view with the following columns[provide the view SQL]

[x] post_code: The Post Code
[x] total_places: The number of places in that Post Code
[x] total_chairs: The total number of chairs in that Post Code
[x] chairs_pct: Out of all the chairs at all the Post Codes, what percentage does this Post Code represent (should sum to 100% in the whole view)
[x] place_with_max_chairs: The name of the place with the most chairs in that Post Code -max_chairs: The number of chairs at the place_with_max_chairs
[x] Please also include a brief description of how you verified #4

Number four was verified with a feature test called post_code_index_spec. In the test, I created records and verified the calculation methods against the test examples. I displayed all of the cafes on the page so I could also have a visual check.

[x] Write a Rails script to categorize the cafes and write the result to the category according to the rules:[provide the script]

If the Post Code is of the LS1 prefix type:
-of chairs less than 10: category = 'ls1 small'
-of chairs greater than or equal to 10, less than 100: category = 'ls1 medium'
-of chairs greater than or equal to 100: category = 'ls1 large'
If the Post Code is of the LS2 prefix type:
-of chairs below the 50th percentile for ls2: category = 'ls2 small'
-of chairs above the 50th percentile for ls2: category = 'ls2 large'
For Post Code is something else:
category = 'other'
[x] Please share any tests you wrote for #5

In the models spec folder, I have a test file called restuarant_spec with a test called update_category that tests all the scenarios I could think of.

[x] Write a custom view to aggregate the categories [provide view SQL AND the results of this view]

[x] category: The category column
[x] total_places: The number of places in that category
[x] total_chairs: The total chairs in that category

[x] Write a script in rails to:

[x] For street_cafes categorized as small, write a script that exports their data to a csv and deletes the records
[x] For street cafes categorized as medium or large, write a script that concatenates the category name to the [x] beginning of the name and writes it back to the name column
[x] Please share any tests you wrote for #7

In the spec folder tasks, there are 3 test files to test all of the take tasks.

Show your work and check your email for submission instructions.

Celebrate, you did great!

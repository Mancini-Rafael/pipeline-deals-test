## Pipeline Deals Test

- **docker-compose:** >=1.25.5

### PROJECT DESCRIPTION
- This project implements a unified front end in ReactJS and a backend in Ruby on Rails
for a simple project where a user lists deals obtained via the PipelineDeals API

### Installing
- The project uses docker and docker-compose to unify all dependencies. To set up, run (in the root folder):
``` bash
  ./docker_setup.sh
  ./docker-compose up
```

### Using
- To run the project you can use either
``` bash
  docker-compose up
```
or if you want to enable STD_IN (for debugger for example)
``` bash
  docker-compose run --service-ports back_end
```
- Commands in general can be run with ```docker-compose run app COMMAND```
- Look at the [```back-end/docker_entrypoint.sh```](back-end/docker_entrypoint.sh) and the 
[```front-end/docker_entrypoint.sh```](front-end/docker_entrypoint.sh) for examples of commands.


### Testing
- Front End
  - The test suite uses jest for functionality testing and es-linter for code quality:
    - Lint (code quality/syntax errors)
    - Tests (components)
  - Using docker-compose:
    - docker-compose run front_end lint
    - docker-compose run front_end test

- Back End
  - The test suite uses Rspec for functionality testing and Rubocop for code quality:
    - Lint (code quality/syntax errors)
    - Tests (components)
  - Using docker-compose:
    - docker-compose run back_end lint
    - docker-compose run back_end test
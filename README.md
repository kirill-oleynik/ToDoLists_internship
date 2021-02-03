# Simple TODO Lists API (internship version)
## Functional Requirements
- I want to be able to sign up/sign in/sign out(username, email,
  password,password_confirmation);
- I want to be able to create/update/delete projects;
- I want to be able to invite other users by email to the project;
- I want to be able to search for a project by partial match;
- I want to make the project publicly readable;
- I want to be able to add task to the project;
- I want to be able to update/delete tasks;
- I want to be able to sort tasks by `priority`, `date`, `status`, and `comments count`;
- I want to be able to prioritize tasks in the project;
- I want to be able to choose deadline to the task (date and time);
- I want to be able to mark a task as completed;
- I want to be able to add comment to the task;
- I want to be able to add comment with an multiple attachments (*.jpg, *.png,
  max size - 10mb);
- I want to be able to delete a comment.
- The system should send a notification to the project owner when the deadline is reached
and provided that the task is still not closed;
- I want to be able to fill in my project tasks by importing a CSV file;
## Technical Requirements
- Use [trailblazer](https://github.com/trailblazer/trailblazer) to build backend part;
- Use [reform](https://github.com/trailblazer/reform) for contract purpose;
API should be implemented based on the [GraphQL](https://github.com/rmosolgo/graphql-ruby);
- Use [jwt_sessions](https://github.com/tuwukee/jwt_sessions) for authentication purpose;
- Use [action_policy](https://github.com/palkan/action_policy) for authorization purpose;
- Implement an ability to upload multiple files via [ActiveStorage](https://guides.rubyonrails.org/active_storage_overview.html);
- Pagination should be implemented based on the [pagy](https://github.com/ddnexus/pagy);
- Use [sidekiq](https://github.com/mperham/sidekiq) for background processing;
- Use [CircleCI](https://circleci.com/) as continuous integration platform;
- Use rubocop family:
  - [rubocop](https://github.com/rubocop-hq/rubocop)
  - [rubocop-rails](https://github.com/rubocop-hq/rubocop-rails)
  - [https://github.com/rubocop-hq/rubocop-performance](https://github.com/rubocop-hq/rubocop-performance)
  - [https://github.com/rubocop-hq/rubocop-rspec](https://github.com/rubocop-hq/rubocop-rspec)
  - [rubocop-graphql](https://github.com/DmitryTsepelev/rubocop-graphql)

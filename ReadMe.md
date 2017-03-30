# Gitlab-Teams-Connector

**Important Notice:**

> This project is part of a learning project of mine. I wanted to get a feel for the difference between different programming languages. In my case Elixir, Ruby (, Rails) and Python.
> This is the ruby version of the app/helper. There exist multiple gitlab-teams-connectors with different feature sets in [my profile](https://github.com/Wachiwi?utf8=✓&tab=repositories&q=gitlab-teams-connector&type=&language=).

# (Un-)Implemented Card(types)

- [X] Card
- [ ] Comment Card
- [ ] Commit Comment Card
- [ ] Issue Comment Card
- [X] Issue Card
- [X] Merge Card
- [ ] Merge Comment Card
- [ ] Snippet Comment Card
- [X] Pipeline Card
- [X] Build Card
- [X] Push Card
- [ ] Wiki Card
- [ ] Tag Card

# Tests

The tests of this project seem (and are) to be very low level, unnecessary. But I wanted to write test to make sure, that at least something is tested. The current focus of the test files/specs are on basic behavior testing based upon the gitlab webhook example files from the documentation.

Further the test try to cover changes inside the structure of the recieving json data and the structure of the outgoing data(objects).

As you read until here I welcome yout to improve the testing as it is now. How

# Documentation

- [Offical Gitlab Documentation](https://gitlab.com/gitlab-org/gitlab-ce/blob/master/doc/user/project/integrations/webhooks.md)


# Contribution

The steps to contribute are simple:

1. Fork the project
2. Create a new branch with a short speaking name to describe your feature
3. Implement your changes inside the branch
4. Commit changes && double-check tests and create an PR

# Licensing

All the source code in this directory and its including subdirectory is licensed by the MIT-License.
What is allowd:
 - Use the source code and use it commercial or non-commercial
 -

What is not allowed:
 - Make me responsive (ToDo: Better description needed)

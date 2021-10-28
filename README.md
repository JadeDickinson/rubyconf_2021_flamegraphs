This is the code for a workshop at Rubyconf 2021.

# How to use flamegraphs to find performance problems
Slow Ruby code can be a puzzle, but it doesn’t have to be that way. In this workshop you will see how fun it can be to use flamegraphs to find performance problems. You’ll get the most out of this session if you know you have slow areas in your Ruby application, and would like to learn how to find the code responsible.

## Prerequisites
This workshop assumes you have a basic grasp of Ruby, either running on Rails or e.g. Sinatra. It is ok if this is from an introductory tutorial.

## Getting ready

This workshop uses Abalone, a Rails app from Ruby for Good, as an example. I'd recommend you set this up locally before the workshop.

To do this, clone a copy of https://github.com/JadeDickinson/rubyconf_2021_flamegraphs onto your local machine, change directory into abalone and follow the setup instructions:
https://github.com/JadeDickinson/rubyconf_2021_flamegraphs/tree/main/abalone#prerequisites

To check you've got everything set up ok, check you can login to the app using these details:
```
Email: admin@whiteabalone.com
Password: password
```

Don’t worry about reading the code in Abalone beforehand - we’ll mainly use it to get comfortable with reading flamegraphs before looking at your own projects.

Please also have a personal or work project you'd like to optimise an area of ready to run locally. For the final section of the workshop we'll get you all set up and hopefully make a start on doing this.

Please send questions about the workshop or setup to Jade in the channel for the workshop, __NAME__, in the conference Discord.

## Notes on use of Abalone as example
Please note my use of Abalone as an example isn't to suggest this app is slow. I simply found while contributing to it last Hacktoberfest that the setup instructions are very clear. It is a good example of a Rails app where we can recognise common patterns in flamegraphs. We’ll mainly use it to get comfortable with reading flamegraphs before looking at your own projects.

If you are interested in contributing to Abalone or other Ruby for Good projects, you can find more information [here](https://github.com/rubyforgood/abalone) and [here](https://github.com/rubyforgood/).
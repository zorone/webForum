# README

This is project for class CPE4254: Internet Engineering
In this class, all students will require to built Web Forum using Ruby on Rails.

* System dependencies

```text
    ruby 3.2.4
    Rails 7.2.1
    SQLite3 3.46.1
```

* Gem dependencies

```text
    "simple_form", "~> 5.3", ">= 5.3.1"
    "bootstrap", "~> 5.3", ">= 5.3.3"
    "sassc-rails", "~> 2.1", ">= 2.1.2"
    "devise", "~> 4.9", ">= 4.9.4"
```

* Configuration

None

* Database creation

You can't create your own database yet.

* Database initialization

No need. Software will initialize them automatically. (Via dockerfile)

* How to run the test suite

Currently, it doesn't support any software testing yet.

* Deployment instructions

To deploy this project, please ensure that your system has `docker` or any container software. And you have already start `dockerd` or `containerd` service. The process below will also require you to have `git` on your system.

## Deployment Procedure

Run the following command:

```bash
cd path/to/your/workspace
git clone https://github.com/zorone/webForum.git webForum  # clone this repository onto your workspace, inside folder name `webForum`
cd webForum                                                # Move yourself inside webForum folder
docker build -t server .                                   # Build docker image with name `server`, using dockerfile as building instruction
docker run -p 3000:3000 server                             # Create container from docker image `server`, and expose port 3000 of the container to port 3000 of the host
```

Now, you can go to `localhost:3000` inside your web browser of choice. It should work without any issue.

## Deploy this project locally

If you prefer using this project on your native system. You'll need these program below. Please ensure that all of them is callable via CLI.

```text
ruby, version 7 or later
SQLite3
```

Next, you'll have to enter the command below.

```bash
cd path/to/your/workspace
git clone https://github.com/zorone/webForum.git webForum  # clone this repository onto your workspace, inside folder name `webForum`
cd webForum                                                # Move yourself inside webForum folder
bundle install                                             # Install all gems that require for this project
rails db:migrate                                           # Ensure that database structure is corrected
rails server -b localhost -p 3000 -e development           # Start your web server at the localhost, using port 3000, with development profile. Now it should accessible via your web browser of choice. These flag is optional, if not given, it will default to localhost, at port 3000, using development profile
```

## Conclusion

After I have used Ruby on Rails for a while. I feel like it lacks in many ways, especially in documentation. Most of the time, I have to encounter some weird issue, where the document is poorly written. Another thing that makes me frustrated a lot is those answers on the websites usually outdated! That is really bad for the language, the framework, and the library aroud it. Me, as the beginner of this language and framework, is very frustrated when encounter the issues while I tried to use them. And with the syntax of the language itself that is too unique from others, it is too hard for the beginner like me to understand all the rules. I still don't fully understand some operation until now. (E.g. `|` operation.) I believed I might need to relearn the basic of ruby, before I could using rails framework to its full potential.

Also, whenever I tried to go out of the guidance zone, I always drop down in the middle of nowhere. Like, for my last work, which about try to run this project on docker. All weird problem risen up like crazy. I don't know how is that even possible...

For my reseach log for this project, visit [here](https://github.com).

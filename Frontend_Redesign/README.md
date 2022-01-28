# **McdonaldsProject 4 - Static Web Site Design**
In this project, we redesigned the personal site of Dr. Tamal Krishna Dey, linked here: http://web.cse.ohio-state.edu/~dey.8/

## **Requirement**
To setup, please first clone all website files using:

    git clone https://github.com/cse3901-2021au-giles/mcdonalds-project4.git

To get all dependencies required for the project, please install these gems into your command line before running: 

    bundle install

## **Getting Started**
To generate the website, please run in your command line:

    bundler exec middleman build

There are two ways afterwards to access the site, you can

    Go into the build directory and open index.html in Firefox 

or you can run the command

    middleman server

and open the statically generated linked website there. You can navigate to any of the pages using the navbar at the top.

## **Navigating The ERB Files**

Note that every .erb file name corresponds to their respective page and title on the navbar except
for index.html.erb, which generates the home page.

## **Known Issues**

If the .html files generated in the /build directory have missing CSS (i.e Navbar looks like a list), make
sure to add

    activate :relative_assets

into the config.rb file or use the middleman server option listed before.

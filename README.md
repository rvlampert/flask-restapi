# RestAPI using Flask

A REST API (also known as RESTful API) is an application programming interface (API or web API) that conforms to the constraints of REST architectural style and allows for interaction with RESTful web services. REST stands for representational state transfer and was created by computer scientist Roy Fielding.

## Objective

Build RestAPI with authentication using Flask

## How to run

Create a virtual environment, use ```make install-dependencies``` command to install the python dependencies, then use ```make run``` to run the program


## User Database

We will use a `Flask-SQLAlchemy` database to store users.
The user model will be very simple. For each user a `username` and a `password_hash` will be stored.

For security reasons the original password will not be stored, after the hash is calculated during registration it will be discarded. If this user database were to fall in malicious hands it would be extremely hard for the attacker to decode the real passwords from the hashes. Passwords should never be stored in the clear in a user database.

## Password Hashing

To create the password hashes we will use `PassLib`, a package dedicated to password hashing.
PassLib provides several hashing algorithms to choose from. The custom_app_context object is an easy to use option based on the sha256_crypt hashing algorithm.

## User Registration

In this example, a client can register a new user with a POST request to /api/users. The body of the request needs to be a JSON object that has username and password fields.

The username and password arguments are obtained from the JSON input coming with the request and then validated.
If the arguments are valid then a new User instance is created. The username is assigned to it, and the password is hashed using the hash_password() method. The user is finally written to the database.

The body of the response shows the user representation as a JSON object, with a status code of 201 and a Location header pointing to the URI of the newly created user.

Note that in a real application this would be done over secure HTTP. There is no point in going through the effort of protecting the API if the login credentials are going to travel through the network in clear text.

## Password Based Authentication

I'm going to use HTTP Basic Authentication, but instead of implementing this protocol by hand I'm going to let the `Flask-HTTPAuth` extension do it for me.

`Flask-HTTPAuth` needs to be given some more information to know how to validate user credentials, and for this there are several options depending on the level of security implemented by the application.

The option that gives the maximum flexibility (and the only that can accomodate PassLib hashes) is implemented through the verify_password callback, which is given the username and password and is supposed to return True if the combination is valid or False if not. Flask-HTTPAuth invokes this callback function whenever it needs to validate a username and password pair.

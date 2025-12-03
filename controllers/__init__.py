from bottle import Bottle
from controllers.home_controller import home_routes
from controllers.auth_controller import auth_routes
from controllers.register_controller import register_routes  
from controllers.user_controller import user_routes
from controllers.task_controller import task_routes
from controllers.projeto_controller import projeto_routes

def init_controllers(app: Bottle):
    app.merge(auth_routes)      # login e logout
    app.merge(register_routes)  
    app.merge(home_routes)      
    app.merge(user_routes)      
    app.merge(task_routes)      
    app.merge(projeto_routes)   
% Copyright 2017 Tim Grunert, Christian Schade, Lars Brandes, Sven Fielsch,
% Claudia Michalik, Matthias Stursberg
%
% This file is part of ODESCA.
% 
% ODESCA is free software: you can redistribute it and/or modify
% it under the terms of the GNU Lesser General Public License as published 
% by the Free Software Foundation, either version 3 of the License, or
% (at your option) any later version.
% 
% ODESCA is distributed in the hope that it will be useful,
% but WITHOUT ANY WARRANTY; without even the implied warranty of
% MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
% GNU Lesser General Public License for more details.
% 
% You should have received a copy of the GNU Lesser General Public License
% along with ODESCA.  If not, see <http://www.gnu.org/licenses/>.

classdef Test_ODESCA_System_CompCommonWT < ODESCA_Component
    %Test_ODESCA_System_WT Example Component for the system tests
    %
    % DESCRIPTION
    %   This class is used for the tests of the ODESCA_System class.
    %
    % ODESCA_Component_Template
    %
    % PROPERTIES:
    %
    %
    % CONSTRUCTOR:
    %   obj = ODESCA_Component_Template()
    %
    % METHODS:
    %
    % LISTENERS
    %
    % NOTE:
    %
    % SEE ALSO
    %
    
    properties
    end
    
    methods
        function obj = Test_ODESCA_System_CompCommonWT(name)
            % Constructor of the component
            %
            % SYNTAX
            %   obj = ODESCA_Component_Template();
            %
            % INPUT ARGUMENTS
            %
            % OPTIONAL INPUT ARGUMENTS
            %
            % OUTPUT ARGUMENTS
            %   obj: new instance of the class
            %
            % DESCRIPTION
            %   In the constructor the construction parameters needed for
            %   the calculation of the equations has to be spezified.
            %
            % NOTE
            %
            % SEE ALSO
            %
            % EXAMPLE
            %
            
            % Set the name if a name was given
            if( nargin == 1 )
                obj.setName(name);
            end
            
            % ---- Instruction ----
            % Define the construction parameters which are needed for the
            % creation of the equations by filling in the names of the
            % construction parameters in the array below. If you don't want
            % to have construction parameters just leave the array empty.
            %
            % NOTE: To access the construction parameter in the sections
            % below use the command:
            %       obj.constructionParam.PARAMETERNAME
            %==============================================================
            %% DEFINITION OF CONSTRUCTION PARAMETERS (User Editable)
            %==============================================================          
            
            constructionParamNames = {};
            
            %==============================================================
            %% Template Code
            obj.addConstructionParameter(constructionParamNames);
            if(isempty(constructionParamNames))
                obj.tryCalculateEquations();
            end 
        end
    end
    
    methods(Access = protected)
        function calculateEquations(obj)
            % Calculates the equations of the component
            %
            % SYNTAX
            %
            % INPUT ARGUMENTS
            %   obj:    Instance of the object where the methode was
            %           called. This parameter is given automatically.
            %
            % OPTIONAL INPUT ARGUMENTS
            %
            % OUTPUT ARGUMENTS
            %
            % DESCRIPTION
            %   In this method the states, inputs, outputs and parameters
            %   are defined and the equations of the component are
            %   calculated.
            %
            % NOTE
            %   - This method is called by the method
            %     tryCalculateEquations() to avoid a call if not all
            %     construction parameters are set.
            %
            % SEE ALSO
            %
            % EXAMPLE
            %
            
            % ---- Instruction ----
            % Define the states, inputs, outputs and parameters in the
            % arrays below by filling in their names as strings. If you
            % don't want states, inputs or parameters, just leave the array
            % empty. It is not possible to create a component without
            % outputs. 
            % The corresponding arrays contain the unit strings for the 
            % states, inputs, outputs and parameters. These arrays must 
            % have the same size as the name arrays!
            %==============================================================
            %% DEFINITION OF EQUATION COMPONENTS (User Editable)
            %==============================================================
            
            stateNames  = {'T_store','T_dhw','T_sens'};
            inputNames  = {'mdot_store','T_store_in','mdot_dhw','T_dhw_in'};
            outputNames = {'T_sens','T_dhw','T_store'};
            paramNames  = {'c','rho','k','A','V_store','V_dhw','tau'};
            
            stateUnits  = {'�C','�C','�C'};
            inputUnits  = {'kg/s','�C','kg/s','�C'};
            outputUnits = {'�C','�C','�C'};
            paramUnits  = {'J/(kg*K)','kg/m^3','W/(m^2*K)','m^2','m^3','m^3','s'};
            
            % =============================================================
            %% Template Code
            obj.initializeBasics(stateNames, inputNames, outputNames, paramNames, stateUnits, inputUnits, outputUnits, paramUnits);
            obj.prepareCreationOfEquations();
            %
            %
            % ---- Instruction ----
            % Use 'obj.f(NUM)' for the state equations and 'obj.g(NUM) for 
            % the output equations e.g. obj.f(1) = ... to access state x1
            %
            % All parameters, states and inputs are in the function
            % workspace so if e.g. a paramter with the name 'radius' is
            % defined you can use the variable 'radius' with out further
            % definition. You can also access the states by 'obj.x(NUM)', 
            % the inputs by 'obj.u(NUM)' and the parameter in the order
            % of the list paramNames by using 'obj.p(NUM)' where NUM
            % is the position.
            %==============================================================
            %% DEFINITION OF EQUATIONS (User Editable)
            %==============================================================
            
            u = obj.u;
            x = obj.x;
                
            obj.f(1) = ( u(1)*c*(u(2)-x(1)) + k*A*(x(2)-x(1)) )/( c*V_store*rho );
            obj.f(2) = ( u(3)*c*(u(4)-x(2)) + k*A*(x(1)-x(2)) )/( c*V_dhw*rho   );
            obj.f(3) = ( x(2) - x(3) ) / tau;
            
            obj.g(1) = x(2);
            obj.g(2) = x(3);
            obj.g(3) = x(1);
            
            %==============================================================
            %% Template Code
            % Sort the equations so they are n x 1 vectors
            if(~isempty(obj.f))
                obj.f = reshape(obj.f,[numel(obj.f),1]);
            end
            if(~isempty(obj.g))
                obj.g = reshape(obj.g,[numel(obj.g),1]);
            end
        end
    end
end


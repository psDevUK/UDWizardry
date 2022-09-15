import React from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import { Wizard } from "react-wizardry";
import "react-wizardry/dist/react-wizardry.css";

const UDWizardry = props => {
  return (
    <div className="WizardryApp">
      <Wizard
        key={props.id}
        validationDelay={props.validationDelay}
        
        onFinish={(val) => console.log(val)}
        bodyHeight={props.bodyHeight}
        stepperItemWidth={props.stepperItemWidth}
        showStepperTitles={props.showStepperTitles} 
        pages={props.pages}
      />
    </div>
  );
}

export default withComponentFeatures(UDWizardry)
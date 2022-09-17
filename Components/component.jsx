import React from 'react';
import { withComponentFeatures } from 'universal-dashboard';
import { Wizard } from "react-wizardry";
import "react-wizardry/dist/react-wizardry.css";

const UDWizardry = props => {
  
  const onFinish = (value) => {
      props.onFinish(value);
      // you can do more stuff here to update the wizard control.
  }
  
  return (
    <div className="WizardryApp">
      <Wizard
        key={props.id}
        validationDelay={props.validationDelay}
        
        onFinish={onFinish}
        bodyHeight={props.bodyHeight}
        stepperItemWidth={props.stepperItemWidth}
        showStepperTitles={props.showStepperTitles} 
        pages={props.pages}
      />
    </div>
  );
}

export default withComponentFeatures(UDWizardry)

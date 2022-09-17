import React from 'react';
import { withComponentFeatures } from 'universal-dashboard'
import { Wizard } from "react-wizardry";
import "react-wizardry/dist/react-wizardry.css";
const onFinish = (value) => {
  props.onFinish(value);
  // you can do more stuff here to update the wizard control.
}
const UDWizardry = props => {
  return (
    <div className="App">
      <Wizard
        key={props.id}
        bodyHeight={props.bodyHeight}
        noPageTitle={props.noPageTitle}
        showStepperTitles={props.showStepperTitles}
        stepperItemWidth={props.stepperItemWidth}
        highlightFieldsOnValidation={props.highlightFieldsOnValidation}
        onFinish={onFinish}
        strict={props.strict}
        pages={props.pages}
        finishMessage={props.finishMessage}
        />
  </div>
  );
}

export default withComponentFeatures(UDWizardry)
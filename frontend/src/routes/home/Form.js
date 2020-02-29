import React from "react";
import {Button, Input, Form, FormGroup} from "reactstrap";

export default class PlateForm extends React.Component {
  state = {
    firstName: "",
    lastName: "",
    email: "",
    plate: ""
  }

  change = e => {
    this.props.onChange({ [e.target.name]: e.target.value });
    this.setState({
      [e.target.name]: e.target.value
    });
  }

  handlePictureUpload = (e, n) => {
    console.log("Load" + n);
  }

  onSubmit = e => {
    e.preventDefault();

    fetch("/platecheck", {
      method: 'POST',
      headers: {
        'Accept': 'application/json',
        'Content-Type': 'application/json',
      },
      body: JSON.stringify(this.state)
    });

    this.setState({
      firstName: "",
      lastName: "",
      email: "",
      plate: ""
    });
    this.props.onChange({
      firstName: "",
      lastName: "",
      email: "",
      plate: ""
    });
  }

  render() {
    return (
      <Form className="text-responsive">
        <FormGroup>
          <Input
            name="firstName"
            placeholder="Nome"
            value={this.state.firstName}
            onChange={e => this.change(e)}
          />
        </FormGroup>
        <FormGroup>
          <Input
            name="lastName"
            placeholder="Cognome"
            value={this.state.lastName}
            onChange={e => this.change(e)}
          />
        </FormGroup>
        <FormGroup>
          <Input
            name="email"
            placeholder="Email"
            value={this.state.email}
            onChange={e => this.change(e)}
          />
        </FormGroup>
        <FormGroup>
          <Input
            name="plate"
            type="plate"
            placeholder="Targa Auto"
            value={this.state.plate}
            onChange={e => this.change(e)}
          />
        </FormGroup>
        <FormGroup>
          <Button onClick={e => this.handlePictureUpload(e, 1)}>Carica Foto 1</Button>
        </FormGroup>
        <FormGroup>
          <Button onClick={e => this.handlePictureUpload(e, 2)}>Carica Foto 2</Button>
        </FormGroup>
        <FormGroup>
          <Button onClick={e => this.handlePictureUpload(e, 3)}>Carica Foto 3</Button>
        </FormGroup>
        <FormGroup>
          <Button onClick={e => this.handlePictureUpload(e, 4)}>Carica Foto 4</Button>
        </FormGroup>
        <FormGroup>
          <Button onClick={e => this.handlePictureUpload(e, 5)}>Carica Foto 5</Button>
        </FormGroup>
        <FormGroup>
          <Button onClick={e => this.handlePictureUpload(e, 6)}>Carica Foto 6</Button>
        </FormGroup>
        <FormGroup>
          <Button onClick={e => this.onSubmit(e)}>Invia</Button>
        </FormGroup>
      </Form>
    );
  }
}

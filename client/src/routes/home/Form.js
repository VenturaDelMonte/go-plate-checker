import React from "react";
import {Button, Input} from "reactstrap";

export default class Form extends React.Component {
  state = {
    firstName: "",
    lastName: "",
    username: "",
    email: "",
    password: ""
  }

  change = e => {
    this.props.onChange({ [e.target.name]: e.target.value });
    this.setState({
      [e.target.name]: e.target.value
    });
  }

  onSubmit = e => {
    e.preventDefault();
    // this.props.onSubmit(this.state);
    this.setState({
      firstName: "",
      lastName: "",
      username: "",
      email: "",
      password: ""
    });
    this.props.onChange({
      firstName: "",
      lastName: "",
      username: "",
      email: "",
      password: ""
    });
  }

  render() {
    return (
      <form>
        <Input
          name="firstName"
          placeholder="First name"
          value={this.state.firstName}
          onChange={e => this.change(e)}
        />
        <br/>
        <Input
          name="lastName"
          placeholder="Last name"
          value={this.state.lastName}
          onChange={e => this.change(e)}
        />
        <br/>
        <Input
          name="username"
          placeholder="Username"
          value={this.state.username}
          onChange={e => this.change(e)}
        />
        <br/>
        <Input
          name="email"
          placeholder="Email"
          value={this.state.email}
          onChange={e => this.change(e)}
        />
        <br/>
        <Input
          name="password"
          type="password"
          placeholder="Password"
          value={this.state.password}
          onChange={e => this.change(e)}
        />
        <br/>
        <Button onClick={e => this.onSubmit(e)}>Submit</Button>
      </form>
    );
  }
}

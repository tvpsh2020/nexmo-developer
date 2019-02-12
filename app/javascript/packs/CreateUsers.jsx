import 'whatwg-fetch'
import React from 'react'

class CreateUsers extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        "users": [],
        "defaultUsers": ['Joe', 'Jane', 'Bob']
    }
  }

  createUsers(event) {
      this.setState({
          "users": [
              {'name': 'Joe', 'id': 'USR-1234-5678'},
              {'name': 'Jane', 'id': 'USR-A927JSD-238DJWD2'},
              {'name': 'Bob', 'id': 'USR-ANF893JW2-S923S'}
          ]
      })
  }

  renderCreateForm() {
      return (
        <div className="Vlt-form__group">
          <button className="Vlt-btn Vlt-btn--secondary Vlt-btn--app" onClick={this.createUsers.bind(this)}>Create {this.state.defaultUsers.length} Users</button>
        </div>
    )
  }

  renderUserRows() {
      var rows = [];
      for (var i = 0; i < this.state.users.length; i++) {
          let user = this.state.users[i];
          rows.push(<tr><td>{user.name}</td><td>{user.id}</td></tr>);
      }
      return rows;
  }

  renderUsersTable(){
      return (
          <div><hr />
          <div className="Vlt-callout Vlt-callout--good">
              <i></i>
              <div className="Vlt-callout__content">
                  <h4>Users Created</h4>
                  <p>You can get these details again in the future using the <a href="/api/conversation#getUsers">List Users</a> endpoint from your server application</p>
              </div>
          </div>
              <div className="Vlt-table">
                  <table>
                      <thead>
                      <th>Name</th>
                      <th>User ID</th>
                      </thead>
                      <tbody>
                      {this.renderUserRows()}
                      </tbody>
                  </table>
              </div>
          </div>
      )
  }

  render() {
      if (this.state.users.length > 0) {
          return this.renderUsersTable();
      }
      return this.renderCreateForm();
  }

}

export default CreateUsers

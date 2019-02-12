import 'whatwg-fetch'
import React from 'react'

class CreateApplication extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
        "privateKey": null,
        "applicationId": 'ABC123-FOO-BAR'
    }
  }

  createApplication(event) {
      this.setState({
          "privateKey": '---BEGIN FAKE PRIVATE KEY---\nFooBarBaz\n---END PRIVATE KEY---'
      })
  }

  renderCreateForm() {
      return (
          <div className="Vlt-form__group">
              <div className="Vlt-form__element">
                  <div className="Vlt-input">
                      <input type="text" placeholder="API Key"/>
                  </div>
              </div>
              <div className="Vlt-form__element">
                  <div className="Vlt-input">
                      <input type="text" placeholder="API Secret"/>
                  </div>
            </div>
            <button className="Vlt-btn Vlt-btn--secondary Vlt-btn--app" onClick={this.createApplication.bind(this)}>Create Application</button>
        </div>
    )
  }

  renderPrivateKey(){
      return (
          <div>
              <hr />
          <div className="Vlt-callout Vlt-callout--good">
              <i></i>
              <div className="Vlt-callout__content">
                  <h4>Application Created</h4>
                  <p>Keep these details safe, we won't be able to show them again</p>
                  <p>If you're working with voice, you'll need to <a href="#">set an Answer URL</a></p>
              </div>
          </div>
              <div>
                  <h5>Your Application ID</h5>
                  <p>{this.state.applicationId}</p>
              </div>
          <div className="Vlt-form__element ">
              <h5>Your Private Key</h5>
              <div className="Vlt-textarea Vlt-margin--top2">
                  <textarea rows="4" cols="50">
                      {this.state.privateKey}
                  </textarea>
              </div>
          </div>
          </div>
      )
  }

  render() {
      if (this.state.privateKey) {
          return this.renderPrivateKey();
      }
      return this.renderCreateForm();
  }

}

export default CreateApplication

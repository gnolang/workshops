package contract // OMIT
import (
	"github.com/CosmWasm/cosmwasm-go/std"
	stdTypes "github.com/CosmWasm/cosmwasm-go/std/types"
	// ...
)

func Execute(deps *std.Deps, env stdTypes.Env, info stdTypes.MessageInfo, msgBz []byte) (*stdTypes.Response, error) {
	if err := msg.UnmarshalJSON(msgBz); err != nil { // codec
		return nil, types.NewErrInvalidRequest("msg JSON unmarshal: " + err.Error())
	}
	switch { // routing
	case msg.Incr != nil:
		return handleMsgIncr(deps, env, info)
	}
	return nil, types.NewErrInvalidRequest("unknown execute request")
}

func handleMsgIncr(deps *std.Deps, env stdTypes.Env, info stdTypes.MessageInfo, req types.NewVotingRequest) (*stdTypes.Response, error) {
	// req.Validate
	// state.GetParams(deps.Storage)
	resBz, err := res.MarshalJSON()
	return &stdTypes.Response{
		Data: resBz,
		Events: []stdTypes.Event{
			types.NewEventIncr(info.Sender),
		},
	}
}

func Query(deps *std.Deps, env stdTypes.Env, msgBz []byte) ([]byte, error) { /* switch case ... */ }

func Instantiate(deps *std.Deps, env stdTypes.Env, info stdTypes.MessageInfo, msgBz []byte) (*stdTypes.Response, error) {
}
func Migrate(deps *std.Deps, env stdTypes.Env, msgBz []byte) (*stdTypes.Response, error)       {}
func Sudo(deps *std.Deps, env stdTypes.Env, msgBz []byte) (*stdTypes.Response, error)          {}
func Reply(deps *std.Deps, env stdTypes.Env, reply stdTypes.Reply) (*stdTypes.Response, error) {}

// ...

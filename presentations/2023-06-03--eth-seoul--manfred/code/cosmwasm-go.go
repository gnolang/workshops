func executeEnqueue(deps *std.Deps, _ types.Env, _ types.MessageInfo, enqueue *Enqueue) (*types.Response, error) {
	iter := deps.Storage.Range(nil, nil, std.Descending)
	nextKey := []byte{FirstKey}
	dbKey, _, err := iter.Next()
	if err == nil {
		nextKey[0] = dbKey[0] + 1 // HL
	}
	value, err := (Item{Value: enqueue.Value}).MarshalJSON()
	if err != nil {
		return nil, err
	}
	deps.Storage.Set(nextKey, value)
	return &types.Response{}, nil
}
